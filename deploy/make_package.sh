#!/bin/bash

if [ $# != 1 ]; then
  echo "Usage: $0 FISCO_BCOS_Path"
  echo "Example: $0 ~/github/FCOS_BCOS"
  exit
fi

fisco_bcos_path="$1"

if [ ${fisco_bcos_path: -1} != "/" ]; then
  fisco_bcos_path=${fisco_bcos_path}"/"
fi

for file_name in "build/eth/fisco-bcos" "build/libcontract/libcontract.a" "build/libsinglepoint/libsinglepoint.a" "build/libpbftseal/libpbftseal.a" "build/libpaillier/libpaillier.a" "build/libraftseal/libraftseal.a" "build/libethcore/libethcore.a" "build/libevm/libevm.a" "build/libevmcore/libevmcore.a" "build/libp2p/libp2p.a" "build/libwebthree/libwebthree.a" "build/libwhisper/libwhisper.a" "build/abi/libabi.a" "build/UTXO/libUTXO.a" "build/utils/libscrypt/libscrypt.a" "libpaillier/paillier.h" "libpaillier/bn.h" "libpaillier/common.h" "libpaillier/typedef.h" "libpaillier/macro.h" "utils/libscrypt/sha256.h" "utils/libscrypt/crypto_scrypt-hexconvert.h" "utils/libscrypt/slowequals.h" "utils/libscrypt/sysendian.h" "utils/libscrypt/libscrypt.h" "utils/libscrypt/b64.h"
do
  file_name=${fisco_bcos_path}${file_name}
  echo $file_name
  cp $file_name package/
done
echo
echo "compled making package."

