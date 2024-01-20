#!/bin/bash

pushd ..
premake5 --cc=clang gmake2
popd
