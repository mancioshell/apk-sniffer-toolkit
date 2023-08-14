#!/bin/bash

# Start ADB Server
adb start-server

# Disable SSL Pinning
objection explore -s 'android sslpinning disable'