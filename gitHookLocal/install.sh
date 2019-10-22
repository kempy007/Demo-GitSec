#!/bin/bash
# Purpose: install example githooks to local repo folder
# Author: M Kemp
# Date: 22nd October 2019

echo "Testing if python dependancy is met"
python --version
if [ $? -eq 0 ]
then 
  echo "Dependancy OK"
  cp pre-commit ../.git/hooks
  cp pre-push ../.git/hooks
  exit 0
else
  echo "Please install Python or set path"
  exit 1
fi
