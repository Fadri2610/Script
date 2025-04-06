echo "🗑️ Removing old parts directories..."
device_codename=vayu
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi
# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/RvOS-CLO/manifest -b tiramisu

# Clone repos
echo "🔹 Cloning repositories..."
git clone --depth=1 -b ros https://github.com/Fadri2610/bagaskara_local_manifests.git .repo/local_manifests
echo "✅ Cloning completed!"

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Clean
#echo "🧹 Running installclean..."
#make deviceclean

# Start build 
echo "🚀 Start compiling..."
./rom-build.sh $device_codename