#!/bin/bash

echo "🧹 Cleaning Flutter project..."

# Kill Android emulator/build processes but not the IDE
if ps aux | grep -v grep | grep -i "android" | grep -v "android-studio" > /dev/null; then
    echo "🔪 Stopping Android processes (keeping IDE running)..."
    pkill -f "qemu"
    sleep 2
fi

# Kill ADB server
if pgrep -f "adb" > /dev/null; then
    echo "🔌 Stopping ADB server..."
    adb kill-server
    sleep 1
fi

# Kill any running Flutter process
if pgrep -f "flutter" > /dev/null; then
    echo "📱 Stopping Flutter processes..."
    pkill -f "flutter"
    sleep 2
fi

# Clean Flutter project
echo "🗑️  Running flutter clean..."
flutter clean

# Remove cache and build directories
echo "🧹 Removing cache directories..."
rm -rf .dart_tool/
rm -rf build/

# Get packages
echo "📦 Getting packages..."
flutter pub get

# Run the app
echo "🚀 Starting Flutter app..."
flutter run

echo "✅ All done!"