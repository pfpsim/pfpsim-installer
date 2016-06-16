#!/bin/bash

WHATCXXCOMPILER=$(./findCXXCompiler.sh)

./install_systemc.sh --tar systemc-2.3.1.tgz --compiler $WHATCXXCOMPILER
