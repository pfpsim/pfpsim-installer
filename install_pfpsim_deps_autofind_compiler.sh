#!/bin/bash
./install_pfpsim_deps_aptget.sh

WHATCXXCOMPILER=$(./findCXXCompiler.sh)

./install_pfpsim_deps_source.sh --$WHATCXXCOMPILER
