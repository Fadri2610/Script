echo "🗑️ Removing old parts directories..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi
# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/alphadroid-project/manifest -b alpha-15.1 --git-lfs

# Clone repos
echo "🔹 Cloning repositories..."
git clone --depth=1 -b adroid https://github.com/Fadri2610/bagaskara_local_manifests.git .repo/local_manifests
echo "✅ Cloning completed!"

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Set up build environment
echo "🔧 Setting up build environment..."
. build/envsetup.sh

# Build configuration (Set build type)
echo "🛠️ Start build configuration..."
# lunch alpha_$device_codename-eng    # For bring-up
lunch alpha_vayu-userdebug  # For testing  
# lunch alpha_$device_codename-user       # For release

# Clean
echo "🧹 Running installclean..."
make deviceclean
# Start build 
echo "🚀 Start compiling..."
make bacon