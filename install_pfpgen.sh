#!/bin/bash

echo "Installing pfpgen..."

sudo apt-get install -y python-setuptools

sudo pip install pfpgen*.whl

echo "Done installing pfpgen."
