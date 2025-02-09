#!/usr/bin/env bash

set -e
set -u
set -o pipefail

DIR=post-install-klassy

mkdir $DIR
cd $DIR
git clone https://github.com/paulmcauley/klassy.git 
chmod +x klassy/install.sh
./klassy/install.sh
cd ..
rm -rf $DIR

