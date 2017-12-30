#!/bin/bash

NEWMAC=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//'`
echo $NEWMAC
sudo ifconfig en0 ether $NEWMAC
