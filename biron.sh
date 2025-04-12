echo "🗑️ Removing old parts directories..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/Black-Iron-Project/manifest -b v15_QPR2 --git-lfs

# Clone repos
echo "🔹 Cloning repositories..."
git clone --depth=1 -b biron https://github.com/Fadri2610/bagaskara_local_manifests.git .repo/local_manifests
echo "✅ Cloning completed!"

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Enable pico GApps
export WITH_GMS=true
export WITH_GMS_VARIANT=pico
export BLACKIRON_BUILDTYPE=UNOFFICIAL
export BLACKIRON_MAINTAINER=Fabi
export TARGET_ENABLE_BLUR=false
# Set up build environment
echo "🔧 Setting up build environment..."
. build/envsetup.sh

# Clean
echo "🧹 Running installclean..."
make deviceclean

# Build configuration
echo "🛠️ Start build configuration..."
blkilunch vayu userdebug

echo "🚀 Start compiling..."
blki b