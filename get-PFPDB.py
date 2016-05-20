#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# pfpgen: Code generation tool for creating models in the PFPSim Framework
#
# Copyright (C) 2016 Concordia Univ., Montreal
#     Samar Abdi
#     Umair Aftab
#     Gordon Bailey
#     Faras Dewal
#     Shafigh Parsazad
#     Eric Tremblay
#
# Copyright (C) 2016 Ericsson
#     Bochra Boughzala
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#


try:
  # For Python 3.0 and later
  from urllib.request import urlopen, Request
except ImportError:
  # Fall back to Python 2's urllib2
  from urllib2 import urlopen, Request

import json
from sys import argv, exit

import argparse

def get_args():
    parser = argparse.ArgumentParser(description='Get things from pfpsim repo')
    parser.add_argument('tag', type=str,help='tag name')
    parser.add_argument("--latest", help="Fetch latest release ignores tag",action="store_true")
    parser.add_argument("--source", help="Fetches the tar.gz source package",action="store_true")
    return parser.parse_args()


args = get_args()
tag_name   = args.tag

fetch_latest = False

if (args.latest):
    fetch_latest = True
    print ("Fetch latest")


deb_suffix = '.whl'

RequestUrl = ""
if fetch_latest:
    RequestUrl = "https://api.github.com/repos/pfpsim/pfpdb/releases/latest"
else:
    RequestUrl = "https://api.github.com/repos/pfpsim/pfpdb/releases/tags/" + tag_name

r = Request(RequestUrl)

resp = urlopen(r).read()
try:
    resp = json.loads(resp)
except:
    resp = json.loads(resp.decode("utf-8"))

print("Got list of assets")
#print resp
download_url = "INVALID"
package_name = "NONE"
if not args.source:
    for asset in resp['assets']:
        if asset['name'].endswith(deb_suffix):
            print("found " + asset['name'])
            download_url = asset['url']
            package_name = asset['name']
else:
    download_url = resp['tarball_url']
    package_name = "pfpgensource.tar.gz"

if not (download_url == "INVALID"):
    print download_url
    r = Request(download_url,None)
    deb_resp = urlopen(r).read()
    print("Successfully downloaded")
    with open(package_name, 'wb') as debfile:
        debfile.write(deb_resp)
