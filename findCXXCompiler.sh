#!/bin/bash

mkdir -p findcxxcompiler
cd findcxxcompiler
echo "project(\"FINDCXX\")" > CMakeLists.txt
cmake ./ > cmakeoutput.txt
CXXCOMPILER=$(grep "The CXX compiler identification is" cmakeoutput.txt)
#echo "$CXXCOMPILER"
cd ../
rm -rf findcxxcompiler
if [[ $CXXCOMPILER == *"Clang"* ]]
then
    echo "clang";
else
    echo "gcc";
fi
