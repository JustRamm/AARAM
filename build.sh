#!/bin/bash

# Install Flutter if not already installed
if ! command -v flutter &> /dev/null; then
    echo "Installing Flutter..."
    git clone https://github.com/flutter/flutter.git -b stable
    export PATH="$PATH:`pwd`/flutter/bin"
fi

# Enable web support
flutter config --enable-web

# Get dependencies
flutter pub get

# Build web version
flutter build web --release

# Copy build output to the expected location
cp -r build/web/* ./
