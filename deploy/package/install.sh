#!/bin/sh

sudo apt-get install -qy --no-install-recommends --allow-unauthenticated cmake build-essential libboost-all-dev libcurl4-openssl-dev libgmp-dev libleveldb-dev libmicrohttpd-dev libminiupnpc-dev uuid-dev

sudo cmake -P cmake_install.cmake
