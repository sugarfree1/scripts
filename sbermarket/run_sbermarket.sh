#!/bin/bash

CWD=`pwd`

BASEDIR=$(dirname $0)
cd $BASEDIR

source ~/.rvm/scripts/rvm

rvm use ruby-2.7.0 > /dev/null
bundle install > /dev/null

ruby ./sbermarket.rb "$@"

cd $CWD

