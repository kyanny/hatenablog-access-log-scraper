#!/bin/sh

set -xe

curl -LO https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar xjvf phantomjs-2.1.1-linux-x86_64.tar.bz2

export PATH=./phantomjs-2.1.1-linux-x86_64/bin:$PATH
phantomjs --version

ruby --version
bundle install --deployment

bundle exec ruby scraper.rb

curl -F file=@ss.png -F channels=$SLACK_CHANNEL -F token=$SLACK_TOKEN https://slack.com/api/files.upload
