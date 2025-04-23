echo "🗑️ Removing old parts directories..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/GenesisOS/manifest.git -b verve-qpr2 --git-lfs

# Clone repos
echo "🔹 Cloning repositories..."
git clone --depth=1 -b genos https://github.com/Fadri2610/bagaskara_local_manifests.git .repo/local_manifests
echo "✅ Cloning completed!"

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Build flags
export GENESIS_MAINTAINER=Fabi 

# Set up build environment
echo "🔧 Setting up build environment..."
. build/envsetup.sh

# Build configuration
echo "🛠️ Start build configuration..."
breakfast vayu

# Clean
echo "🧹 Running installclean..."
make deviceclean

echo "🚀 Start compiling..."
mka genesis