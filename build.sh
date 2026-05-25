#!/bin/bash
# Download the Flutter SDK stable branch
git clone https://github.com -b stable --depth 1

# Add Flutter to the temporary environment path
export PATH="$PATH:`pwd`/flutter/bin"

# Run the build command
flutter build web --release
