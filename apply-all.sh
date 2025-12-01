#!/bin/bash

cd scripts || exit 1
find . -maxdepth 1 -name "*.sh" -exec bash {} \;
