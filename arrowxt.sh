echo "🗑️ Removing old parts directories..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi
# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/ArrowOS-Extended/android_manifest.git -b arrow-13.1 --git-lfs

# Clone repos
echo "🔹 Cloning repositories..."
git clone --depth=1 -b arrowxt https://github.com/Fadri2610/bagaskara_local_manifests.git .repo/local_manifests
echo "✅ Cloning completed!"

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Set up build environment
echo "🔧 Setting up build environment..."
source build/envsetup.sh

# Clean
#echo "🧹 Running installclean..."
#make installclean

# Enable core GApps
export TARGET_CORE_GMS=true

# Clone keys
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=18fq-s0tqc6nprr5GGloHOhZx07dZF3uV' -O keys.zip && unzip keys.zip && rm keys.zip && cp extra/keys/* vendor/arrow/signing/keys/ && rm -rf extra

# Build configuration
echo "🛠️ Start build configuration..."
lunch arrow_vayu-user

echo "🚀 Start compiling..."
m bacon