#!/bin/bash


# Clean up APT
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# delete the build directory (including this script)
rm -rf /base_build
