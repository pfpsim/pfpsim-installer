#!/bin/bash
#
# pfpsim-installer: Graphical installer for the PFPSim Framework
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


# Author: Lemniscate Snickets
#	        Eric Tremblay
# Created On: 14/09/15

echo "Installing SystemC..."

while [[ $# > 1 ]]
do
key="$1"

case $key in
  --tar)
  SYSTEMC_TAR="$2"
  shift
  ;;
  --compiler)
  COMPILER="$2"
  shift
  ;;
esac
shift
done

if [ -z ${SYSTEMC_TAR+x} ]; then
  echo "**ERROR: Must specify the path to the tar using --tar <path>"
  exit
else
  echo TAR LOCATION = "${SYSTEMC_TAR}"
fi

if [ -z ${COMPILER+x} ]; then
  echo "**ERROR: Must specify a compiler using --compiler clang|gcc"
else
  echo COMPILER = "${COMPILER}"
fi

SYSTEMC_HOME=/usr/local/systemc

SYSTEMC_TAR_DIR="$(dirname ${SYSTEMC_TAR})"
mkdir tmp-systemc
cp ${SYSTEMC_TAR} tmp-systemc
cd tmp-systemc
tar -xzvf ${SYSTEMC_TAR}
cd systemc*
mkdir build
cd build
if [ "$COMPILER" == "clang" ]; then
  ../configure --prefix=$SYSTEMC_HOME CC=clang CXX=clang++ CPP='clang++ -E' CFLAGS=-stdlib=libstdc++ CXXFLAGS=-stdlib=libstdc++ -std=c++11
elif [ "$COMPILER" == "gcc" ]; then
  ../configure --prefix=$SYSTEMC_HOME CC=gcc CXX=g++ CPP='g++ -E' CXXFLAGS=-std=c++11
  #cmake ../ -DCMAKE_CXX_STANDARD=11
  #cmake --build
else
  echo "**ERROR: Invalid compiler! Please use clang or gcc"
  exit
fi
make
echo "Making"
sudo make install

cd ../../..

sudo rm -rf tmp-systemc

sudo ldconfig
echo "Done installing SystemC."
