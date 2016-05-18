#!/bin/bash

echo "Installing pfpdb..."

sudo apt-get install -y python-setuptools

sudo pip install pfpdb*.whl

echo "Done installing pfpdb."
