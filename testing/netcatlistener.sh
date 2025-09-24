#!/bin/bash
rm /tmp/ncout.txt
nohup nc -l > /tmp/ncout.txt
