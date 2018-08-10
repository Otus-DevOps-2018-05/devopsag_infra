#!/bin/bash
git clone -b monolith https://github.com/express42/reddit.git
gem install bundler
cd reddit && bundle install
puma -d
