#!/bin/bash

echo "This script will (hopefully) get a working iPod touch (2nd generation) emulator running on your Apple Silicon Macintosh. This will use about 2.6GB of disk space."
sleep 0.5
echo "If your computer has an Intel processor, you've executed the wrong script and the process WILL fail."
sleep 0.5

cd $HOME
mkdir ipod2
cd ipod2

# grab files (this may take a while)
echo "grabbing bootrom"
curl -L https://github.com/devos50/qemu-ios/releases/download/n72ap_v1/bootrom_240_4 --output rom
echo "grabbing nor"
curl -L  https://github.com/devos50/qemu-ios/releases/download/n72ap_v1/nor_n72ap.bin --output nor.bin
echo "grabbing nand (this one can take a while)"
curl -L https://github.com/devos50/qemu-ios/releases/download/n72ap_v1/nand_n72ap.zip --output nand.zip
echo "unzipping nand (zip file will be removed when this is done)"
unzip -q nand.zip
echo "done unzipping"
rm nand.zip
echo "files downloaded and in place, don't touch anything"

# GitHub time
echo "grabbing qemu source"
# go home loser
cd $HOME
git clone --quiet https://github.com/devos50/qemu-ios.git
# go to where we're building
cd qemu-ios

# deps
echo "grabbing dependencies"
brew install glib ninja pixman pkg-config sdl2 >> /dev/null

# configure the thing
echo "doing some config"
./configure --enable-sdl --target-list=arm-softmmu --disable-capstone --disable-pie --disable-slirp --extra-cflags=-I/opt/homebrew/opt/openssl@3/include --extra-ldflags='-L/opt/homebrew/opt/openssl@3/lib -lcrypto' >> /dev/null
echo "config is done"

# compile the thing
# set cores to 7 to keep one free for overhead (apple silicon macs have 8 cores minimum)
echo "time to compile, this will use 7 cpu cores"
make -j7

# DONE!
echo "if you've made it this far, congratulations, you downloaded the necessary files, compiled the qemu source code, and nothing went wrong! in a moment, the emulator will launch for the first time. please note that anything you do inside the emulator will not be saved; every time you launch it, it will revert to a like-new state. additionally, a new script has been created on your desktop called boot_ipod.sh. run that, and the emulator will launch."
sleep 12
./build/arm-softmmu/qemu-system-arm -M iPod-Touch,bootrom=$HOME/ipod2/rom,nand=$HOME/ipod2/nand,nor=$HOME/ipod2/nor.bin -serial mon:stdio -cpu max -m 2G -d unimp >> /dev/null

# EXPERIMENTAL
cd $HOME/Desktop
touch boot_ipod.sh
echo "cd $HOME/qemu-ios && ./build/arm-softmmu/qemu-system-arm -M iPod-Touch,bootrom=$HOME/ipod2/rom,nand=$HOME/ipod2/nand,nor=$HOME/ipod2/nor.bin -serial mon:stdio -cpu max -m 2G -d unimp" > boot_ipod.sh
chmod +x boot_ipod.sh
