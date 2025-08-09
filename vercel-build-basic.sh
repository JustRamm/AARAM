#!/bin/bash

set -e

echo "🚀 Starting AARAM Flutter Web Build (Basic)..."
echo "🕐 Build timestamp: $(date)"

# Configure Git
echo "🔧 Configuring Git..."
git config --global --add safe.directory '*' || true
git config --global user.email "abirambijoy@gmail.com" || true
git config --global user.name "JustRamm" || true

# Install Flutter using git clone (most reliable method)
echo "📦 Installing Flutter..."
if [ ! -d "flutter" ]; then
    echo "Cloning Flutter repository..."
    git clone https://github.com/flutter/flutter.git -b stable
fi

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
