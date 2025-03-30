echo "🗑️ Removing old parts directories..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

# Clone ROM source
echo "📦 Cloning ROM source..."
repo init -u https://github.com/BlissRoms/stable_releases.git -b refs/tags/v18.4-stable-voyager --git-lfs

# Clone local_manifests repository
echo "Cloning local_manifests..."
if git clone https://github.com/Fadri2610/bagaskara_local_manifests.git --depth 1 -b Test .repo/local_manifests; then
    echo "✅ local_manifests cloned successfully."
else
    echo "❌ Git clone failed. Attempting fallback download..."

    # Optional fallback: download as ZIP and unzip
    mkdir -p .repo/local_manifests
    curl -L https://github.com/Fadri2610/bagaskara_local_manifests/archive/refs/heads/Test.zip -o temp.zip

    if unzip temp.zip -d .repo; then
        mv .repo/local_manifests-Test/* .repo/local_manifests/
        rm -rf .repo/local_manifests-Test temp.zip
        echo "✅ Fallback succeeded."
    else
        echo "❌ Fallback also failed. Please check your internet connection or the repo URL."
        exit 1
    fi
fi

# repo sync
echo "🔄 Syncing sources..."
/opt/crave/resync.sh

# Clean
#echo "🧹 Running installclean..."
#make installclean

# Set up build environment
echo "🔧 Setting up build environment..."
source build/envsetup.sh

# Build configuration
lunch bliss_vayu-user
blissify -g vayu