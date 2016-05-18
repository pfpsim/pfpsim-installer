#!/bin/bash

echo "Installing pfpsim dependencies..."

if [ "$1" == "--clang" ]; then
  echo "COMPILER: clang"
  COMPILER="clang"
elif [ "$1" == "--gcc" ]; then
  echo "COMPILER: gcc"
  COMPILER="gcc"
else
  COMPILER=""
fi

# Dependencies that can be apt-get'ed
sudo apt-get update

sudo apt-get install -y \
  cmake \
  git \
  g++ \
  clang \
  autoconf \
  libpcap-dev \
  libtool \
  libc++abi1 libc++abi-dev \
  libc++1 libc++-dev \
  flexc++ \
  bisonc++ \
  doxygen \

# protobuf
PROTOBUF_URL=https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz

mkdir tmp-proto
cd tmp-proto

wget -O protobuf.tar.gz $PROTOBUF_URL

tar -xzvf protobuf.tar.gz

cd protobuf*
./autogen.sh

if [ "$COMPILER" == "clang" ]; then
  ./configure CC=clang CXX=clang++ CXXFLAGS='-std=c++11 -stdlib=libstdc++' LDFLAGS='-stdlib=libstdc++'
elif [ "$COMPILER" == "gcc" ]; then
  ./configure CC=gcc CXX=g++
else
  ./configure
fi

make
sudo make install

cd ../..

sudo rm -rf tmp-proto

# nanomsg
NANOMSG_URL=http://download.nanomsg.org/nanomsg-0.5-beta.tar.gz

mkdir tmp-nano
cd tmp-nano

wget -O nanomsg.tar.gz $NANOMSG_URL

tar -xzvf nanomsg.tar.gz

cd nanomsg*

if [ "$COMPILER" == "clang" ]; then
  ./configure CC=clang CXX=clang++ CXXFLAGS='-std=c++11 -stdlib=libstdc++' LDFLAGS='-stdlib=libstdc++'
elif [ "$COMPILER" == "gcc" ]; then
  ./configure CC=gcc CXX=g++
else
  ./configure
fi

make
sudo make install

cd ../..

sudo rm -rf tmp-nano

# P4 Dependencies
# apt-get dependencies
sudo apt-get install -y \
    automake \
    libjudy-dev \
    libgmp-dev \
    libboost-dev \
    libboost-test-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-thread-dev \
    libevent-dev \
    libtool \
    flex \
    bison \
    pkg-config \
    libssl-dev \
    mktemp \
    libffi-dev \
    python-dev \
    python-pip

# Thrift
THRIFT_URL=http://archive.apache.org/dist/thrift/0.9.2/thrift-0.9.2.tar.gz

mkdir tmp-thrift
cd tmp-thrift

wget -O thrift.tar.gz $THRIFT_URL
tar -xzvf thrift.tar.gz
cd thrift*

if [ "$COMPILER" == "clang" ]; then
  ./configure CC=clang CXX=clang++ CXXFLAGS='-std=c++11 -stdlib=libstdc++' LDFLAGS='-stdlib=libstdc++' \
    --with-cpp=yes --with-c_glib=no --with-java=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no
elif [ "$COMPILER" == "gcc" ]; then
  ./configure CC=gcc CXX=g++ \
    --with-cpp=yes --with-c_glib=no --with-java=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no
else
  ./configure --with-cpp=yes --with-c_glib=no --with-java=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no
fi

make
sudo make install

cd ../..

sudo rm -rf tmp-thrift

echo "Done installing pfpsim dependencies."
