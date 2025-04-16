echo "🗑️ Removing old parts directories..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
#rm -rf vendor/xiaomi

# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs

# Clone repos
echo "🔹 Cloning repositories..."
git clone --depth=1 -b evox https://github.com/Fadri2610/build_roomservice.git .repo/local_manifests
echo "✅ Cloning completed!"

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Set up build environment
echo "🔧 Setting up build environment..."
. build/envsetup.sh

# Run clean
echo "🧹 Running deviceclean..."
make deviceclean

# Build configuration (first time)
echo "🛠️ Start build configuration..."
lunch lineage_vayu-bp1a-userdebug

echo "🚀 Start compiling..."
m evolution