#!/bin/bash
set -e

# Define directories
TOOLS_DIR=~/android-cmdline-tools
SDK_ROOT=$TOOLS_DIR/latest
BUILD_TOOLS_VERSION=34.0.0

# Download command line tools if not already present
if [ ! -d "$TOOLS_DIR" ]; then
  mkdir -p $TOOLS_DIR
  cd $TOOLS_DIR
  wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip
  unzip cmdline-tools.zip -d temp
  mv temp/cmdline-tools $TOOLS_DIR/latest
  rm -rf temp cmdline-tools.zip
fi

# Add sdkmanager to path
export PATH=$SDK_ROOT/bin:$PATH

# Accept licenses
yes | sdkmanager --licenses

# Install build-tools
sdkmanager "build-tools;$BUILD_TOOLS_VERSION"

# Set PATH to use new apksigner
export PATH=$SDK_ROOT/../build-tools/$BUILD_TOOLS_VERSION:$PATH

echo "✅ apksigner located at: $(which apksigner)"
echo "🎯 apksigner version info:"
apksigner --help | grep stamp || echo '❌ ERROR: --stamp not supported'

echo ""
echo "✅ Now use apksigner like this:"
echo "apksigner sign \
  --ks testdpc.jks \
  --ks-pass pass:android \
  --key-pass pass:android \
  --ks-key-alias testdpc \
  --v1-signing-enabled true \
  --v2-signing-enabled true \
  --v3-signing-enabled true \
  --stamp \
  --out app-release-signed.apk \
  app-release.apk"
