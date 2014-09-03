import urllib
import pycurl
import json
from StringIO import StringIO
from distutils.version import StrictVersion
import argparse


def curl_post(url, data):
    c = pycurl.Curl()
    return_string = StringIO()
    c.setopt(pycurl.URL, url)
    c.setopt(pycurl.POST, 1)
    c.setopt(pycurl.POSTFIELDS, urllib.urlencode(data))
    c.setopt(pycurl.WRITEDATA, return_string)
    c.perform()
    c.close()
    result = return_string.getvalue()
    print result
    return json.loads(result)


def curl_get(url):
    buffer = StringIO()
    c = pycurl.Curl()
    c.setopt(pycurl.URL, url)
    c.setopt(pycurl.HTTPGET, 1)
    c.setopt(pycurl.WRITEDATA, buffer)
    c.perform()
    c.close()
    json_data = buffer.getvalue()
    print json_data
    return json.loads(json_data)


def curl_put(url, data):
    c = pycurl.Curl()
    return_string = StringIO()
    c.setopt(pycurl.URL, url)
    c.setopt(pycurl.CUSTOMREQUEST, "PUT")
    c.setopt(pycurl.POSTFIELDS, urllib.urlencode(data))
    c.setopt(pycurl.WRITEDATA, return_string)
    c.perform()
    c.close()
    result = return_string.getvalue()
    print result
    return json.loads(result)


def main():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--box', dest='box', help='box name on vagrant cloud')
    parser.add_argument('--rversion', dest='release_version', help='box name on vagrant cloud')
    parser.add_argument('--provider', dest='provider')

    args = parser.parse_args()

    print args

    new_major_and_minor_version = StrictVersion(args.release_version)
    token = "k7UpZB-1uxA8RoMVdaLhKNAH8ykSCZ2wsiPPP64c8xJW1DKrz1kbzqjgsH-ZcJNGyKx"
    vagrant_cloud_url = 'https://vagrantcloud.com/api/v1/box'
    vagrant_box = args.box

    # get box info
    vagrant_cloud_box_info = '%s/%s?access_token=%s' % (vagrant_cloud_url, vagrant_box, token)
    box_info = curl_get(vagrant_cloud_box_info)

    # get current version number
    current_version = StrictVersion(box_info["current_version"]["version"])

    # get new version
    if new_major_and_minor_version <= current_version:
        new_version = StrictVersion(str(current_version.version[0]) + "." +
                                    str(current_version.version[1]) + "." +
                                    str(current_version.version[2] + 1))
    else:
        new_version = StrictVersion(str(new_major_and_minor_version.version[0]) + "." +
                                    str(new_major_and_minor_version.version[1]) + ".0")

    new_version_string = ""
    for i, var in enumerate(new_version.version):
        new_version_string += str(var)
        if not i == len(new_version.version) - 1:
            new_version_string += "."

    provider = args.provider
    provider_name = provider.split("=")[0]
    provider_url = provider.split("=")[1]

    founded = False
    # if current version don't have this provider, post provider on this version
    for provider in box_info["current_version"]["providers"]:
        if provider["name"] == provider_name:
            founded = True

    if not founded:
        # post on this version
        url = "%s/%s/version/%s/providers" % (vagrant_cloud_url, vagrant_box, box_info["current_version"]["number"])
        post_data = {"provider[name]": provider_name, "access_token": token, "provider[url]": provider_url}
        result = curl_post(url, post_data)
    else:
        # post a new version
        post_data = {"version[version]": "%s" % new_version_string, "access_token": token}
        vagrant_box_version = "%s/%s/versions" % (vagrant_cloud_url, vagrant_box)
        result = curl_post(vagrant_box_version, post_data)

        print result

        if "error" in result.keys():
            raise IOError(result["error"])

        vagrant_version_number = result["number"]
        # post providers
        url = "%s/%s/version/%s/providers" % (vagrant_cloud_url, vagrant_box, vagrant_version_number)
        post_data = {"provider[name]": provider_name, "access_token": token, "provider[url]": provider_url}
        result = curl_post(url, post_data)
        # release version
        url = "%s/%s/version/%s/release" % (vagrant_cloud_url, vagrant_box, vagrant_version_number)
        post_data = {"access_token": token}
        result = curl_put(url, post_data)


if __name__ == "__main__":
    main()

