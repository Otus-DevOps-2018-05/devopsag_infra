#!/bin/bash
git clone -b monolith https://github.com/express42/reddit.git
sudo gem install bundler
cd reddit && bundle install
cd /etc/systemd/system
echo "[Unit]
Description=Puma Server
After=network.target

[Service]
Type=simple

WorkingDirectory=/home/appuser/reddit

ExecStart=/usr/local/bin/puma
[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl enable puma.service
