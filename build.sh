#!/bin/bash


# Add Flutter to the temporary environment path
export PATH="$PATH:`pwd`/flutter/bin"

# Run the build command
flutter build web --release
