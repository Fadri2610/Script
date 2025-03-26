#!/bin/bash

rm -rf .repo/local_manifests/

# Local TimeZone
#sudo rm -rf /etc/localtime
#sudo ln -s /usr/share/zoneinfo/Asia/India /etc/localtime

# Rom source repo
repo init -u https://github.com/Project-Mist-OS/manifest -b 15 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local_manifests repository
git clone -b mos https://github.com/Fadri2610/local_manifests.git .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Signed Keys
#crave ssh && git clone https://github.com/Evolution-X/vendor_evolution-priv_keys-template vendor/evolution-priv/keys && cd vendor/evolution-priv/keys && ./keys.sh && exit

# Clone Gapps
#rm -rf vendor/gms
#rm -rf vendor/gapps
#git clone https://gitlab.com/sachinbarange86/vendor_gapps_axion.git -b vic vendor/gapps

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Export
export BUILD_USERNAME=Fabi
export BUILD_HOSTNAME=AsusROG
echo "======= Export Done ======"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
mistify vayu user
echo "============="

# Make cleaninstall
make installclean
echo "============="

# Build rom
mist b