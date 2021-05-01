#!/bin/bash

filename=${PWD}/my_env_`printf '%(%Y-%m-%d_%H-%M-%S)T\n' -1`

virtualenv --python=/usr/bin/python3.7 $filename
source $filename/bin/activate

pip install bpython
