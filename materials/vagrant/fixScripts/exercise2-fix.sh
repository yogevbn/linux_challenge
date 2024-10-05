#!/bin/bash
#add fix to exercise2 here
sudo sed -i 's/^127\.0\.0\.1 www\.ascii-art\.de/#&/' /etc/hosts
sudo systemd-resolve --flush-caches
