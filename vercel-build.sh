#!/bin/bash

set -e

echo "🚀 Starting AARAM Flutter Web Build on Vercel..."

# Install Flutter using the official installation method
if ! command -v flutter &> /dev/null; then
    echo "📦 Installing Flutter..."
    
    # Download Flutter SDK
    FLUTTER_VERSION="3.19.0"
    FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz"
    
    # Download and extract Flutter
    wget -qO- $FLUTTER_URL | tar xJ
    export PATH="$PATH:`pwd`/flutter/bin"
    
    echo "✅ Flutter installed successfully"
fi

# Verify Flutter installation
echo "🔍 Flutter version:"
flutter --version

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
