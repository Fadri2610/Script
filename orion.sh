echo "🗑️ Removing old parts directories..."
# WARNING: .repo/manifests/ is critical (only delete if intentional!)
rm -rf \
    .repo/local_manifests/ \
    #.repo/manifests/ \
    #device/xiaomi \
    kernel/xiaomi \
    vendor/xiaomi

# Clone ROM source
echo "📦 Cloning ROM source..."
echo -e "\n
   ╔════════════════════════╗
   ║     OrionOS Project    ║
   ╚════════════════════════╝
\n"
repo init -u https://github.com/Fadri2610/orion_manifest.git -b vic --git-lfs

# Clone local_manifests repository
echo "Cloning local_manifests..."
git clone --depth=1 -b orion https://github.com/Fadri2610/bagaskara_local_manifests.git .repo/local_manifests
echo "✅ local_manifests cloned successfully."

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Set up build environment
echo "🔧 Setting up build environment..."
source build/envsetup.sh

export ORION_MAINTAINER=Fabi
export ORION_MAINTAINER_LINK=https://t.me/fabianflores2610
export ORION_BUILD_TYPE=Unofficial
export ORION_GAPPS=true
export TARGET_BOOT_ANIMATION_RES=1080

# Clean
echo "🧹 Running clean..."
make deviceclean

# Build configuration
echo "🛠️ Start build configuration..."
lunch orion_vayu-ap4a-userdebug

echo "🚀 Start compiling..."
make orion -j$(nproc --all)