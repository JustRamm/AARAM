#!/bin/bash

set -e

echo "🚀 Starting AARAM Flutter Web Build..."

# Configure Git for Vercel environment
echo "🔧 Configuring Git for deployment environment..."
git config --global --add safe.directory '*' || true
git config --global user.email "deploy@example.com" || true
git config --global user.name "Deploy Bot" || true

# Install Flutter if not already installed
if ! command -v flutter &> /dev/null; then
    echo "📦 Installing Flutter..."
    
    # Download Flutter using curl (more reliable than git clone)
    FLUTTER_VERSION="3.32.8"
    FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz"
    
    echo "📥 Downloading Flutter $FLUTTER_VERSION..."
    curl -sSL $FLUTTER_URL | tar xJ
    export PATH="$PATH:`pwd`/flutter/bin"
    
    # Fix Git ownership issues for Flutter repository
    if [ -d "flutter" ]; then
        echo "🔧 Fixing Git ownership for Flutter repository..."
        cd flutter
        git config --global --add safe.directory `pwd` || true
        cd ..
    fi
fi

echo "✅ Flutter version:"
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
echo "📁 Build output location: build/web/"
