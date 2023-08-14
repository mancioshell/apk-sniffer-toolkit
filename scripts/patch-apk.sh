#!/bin/bash

# Get app from Device
APP_NAME=$1

cd /usr/src/app/patch-apk/

# Patch apk
python3 patch-apk.py --disable-styles-hack --verbose $APP_NAME