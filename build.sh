#!/bin/bash

set -e

echo "🚀 Starting AARAM Flutter Web Build..."

# Install Flutter if not already installed
if ! command -v flutter &> /dev/null; then
    echo "📦 Installing Flutter..."
    
    # Download Flutter
    git clone https://github.com/flutter/flutter.git -b stable
    export PATH="$PATH:`pwd`/flutter/bin"
    
    # Pre-download Dart SDK
    flutter doctor --android-licenses || true
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
