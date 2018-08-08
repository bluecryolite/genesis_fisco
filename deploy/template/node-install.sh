#!/bin/sh

if [ $# != 8 ]; then
  echo "Usage: $0 targetPath certPath existsChainIP existsChainPort localIP localRpcPort localP2PPort localChannelPort "
  echo "Example: $0 /datas/bcos/node01 ../cert/SellerA/node01 127.0.0.1 30303 127.0.0.1 8546 30305 30306"
  exit
fi

if [ -d "$1" ]; then
  echo "Target node path ($1) has exists."
  exit
fi

nc -z $3 $4
if [ $? -eq 1 ]; then
  echo "Cannot connect to $3:$4"
  exit
fi

lsof -i:$6,$7,$8
if [ $? -eq 0 ]; then
  echo 'local port(s) upon used.'
  exit
fi

mkdir -p "$1"
mkdir -p "$1/data"
mkdir -p "$1/log"
mkdir -p "$1/keystore"

bootJsonFileName=bootstrapnodes.json
bootJsonFile=$1/data/$bootJsonFileName
configJsonFile=$1/config.json

cp * $1
cp $2/* $1/data

mv $1/$bootJsonFileName $bootJsonFile
sed -i "s/#host#/$3/g" $bootJsonFile
sed -i "s/#port#/$4/g" $bootJsonFile

sed -i "s/#host#/$5/g" $configJsonFile
sed -i "s/#rpcPort#/$6/g" $configJsonFile
sed -i "s/#p2pPort#/$7/g" $configJsonFile
sed -i "s/#channelPort#/$8/g" $configJsonFile

