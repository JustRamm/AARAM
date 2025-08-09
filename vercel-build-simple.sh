#!/bin/bash

set -e

echo "🚀 Starting AARAM Flutter Web Build (Simplified)..."
echo "🕐 Build timestamp: $(date)"

# Configure Git to handle ownership issues
echo "🔧 Configuring Git for Vercel environment..."
git config --global --add safe.directory '*' || true
git config --global user.email "abirambijoy@gmail.com" || true
git config --global user.name "JustRamm" || true

# Check if we're in Vercel environment
if [ -n "$VERCEL" ]; then
    echo "🌐 Running in Vercel environment"
fi

# Clean up any existing Flutter installation
echo "🧹 Cleaning up any existing Flutter installation..."
rm -rf flutter || true

# Install Flutter using direct download
echo "📦 Installing Flutter..."
FLUTTER_VERSION="3.32.8"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz"

# Download and extract Flutter with better error handling
echo "📥 Downloading Flutter $FLUTTER_VERSION..."
if command -v curl &> /dev/null; then
    echo "Using curl to download Flutter..."
    curl -sSL $FLUTTER_URL | tar xJ
elif command -v wget &> /dev/null; then
    echo "Using wget to download Flutter..."
    wget -qO- $FLUTTER_URL | tar xJ
else
    echo "❌ Neither curl nor wget found. Trying alternative approach..."
    # Try using git to clone Flutter
    git clone https://github.com/flutter/flutter.git -b stable
fi

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Disable Git operations in Flutter to avoid ownership issues
if [ -d "flutter" ]; then
    echo "🔧 Configuring Flutter repository..."
    cd flutter
    git config --global --add safe.directory `pwd` || true
    git config --global --add safe.directory /vercel/path0/flutter || true
    git config --global --add safe.directory /vercel/path0 || true
    # Disable Git version checking
    export FLUTTER_GIT_URL=""
    export FLUTTER_STORAGE_BASE_URL=""
    cd ..
fi

echo "✅ Flutter installed successfully"

# Verify Flutter installation
echo "🔍 Flutter version:"
flutter --version || echo "⚠️ Flutter version check failed, continuing..."

# Enable web support
echo "🌐 Enabling web support..."
flutter config --enable-web

# Get dependencies
echo "📚 Getting dependencies..."
flutter pub get

# Build web version
echo "🔨 Building web version..."
flutter build web --release

echo "✅ Build completed successfully!"
ls -la build/web/
