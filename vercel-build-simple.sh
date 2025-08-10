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

# Install Flutter using git clone (more reliable)
echo "📦 Installing Flutter..."
echo "Cloning Flutter repository..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Configure Flutter repository
if [ -d "flutter" ]; then
    echo "🔧 Configuring Flutter repository..."
    cd flutter
    git config --global --add safe.directory `pwd` || true
    git config --global --add safe.directory /vercel/path0/flutter || true
    git config --global --add safe.directory /vercel/path0 || true
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

# Build web version with simpler configuration
echo "🔨 Building web version..."
flutter build web --release

echo "✅ Build completed successfully!"
echo "📁 Build output:"
ls -la build/web/
echo "📄 Checking for main.dart.js:"
ls -la build/web/main.dart.js || echo "❌ main.dart.js not found!"
