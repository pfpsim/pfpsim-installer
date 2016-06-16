#!/bin/bash

WHATCXXCOMPILER=$(./findCXXCompiler.sh)

./install_pfpsim_deps.sh --$(WHATCXXCOMPILER)
