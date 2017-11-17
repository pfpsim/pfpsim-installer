#!/bin/bash

WHATCXXCOMPILER=$(./findCXXCompiler.sh)

./install_systemc.sh --tar "systemc-*" --compiler $WHATCXXCOMPILER
