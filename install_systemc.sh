#!/bin/bash

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
  ../configure --prefix=$SYSTEMC_HOME CC=clang CXX=clang++ CPP='clang++ -E' CFLAGS=-stdlib=libstdc++ CXXFLAGS=-stdlib=libstdc++
elif [ "$COMPILER" == "gcc" ]; then
  ../configure --prefix=$SYSTEMC_HOME CC=gcc CXX=g++ CPP='g++ -E'
else
  echo "**ERROR: Invalid compiler! Please use clang or gcc"
  exit
fi
make
sudo make install

cd ../../..

sudo rm -rf tmp-systemc

sudo ldconfig
echo "Done installing SystemC."
