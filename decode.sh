#!/bin/bash
# Purpose: To decode base64 version and write private.key for demo
# Author: M Kemp
# Date: 22nd October 2019

base64 -d private.b64 > private.key
