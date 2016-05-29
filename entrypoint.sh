#!/bin/bash

set -e

mkdir -p '/steemdata/witness_node_data_dir'
cp '/usr/local/steem/config.ini' '/steemdata/witness_node_data_dir/'
cd '/steemdata'
exec steemd "$@"
