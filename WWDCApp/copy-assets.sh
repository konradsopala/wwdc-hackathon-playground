#!/bin/bash

# Helper script to copy all required images from playground to Xcode project
# Usage: ./copy-assets.sh <path-to-your-xcode-project>/Assets.xcassets

if [ -z "$1" ]; then
    echo "Usage: ./copy-assets.sh <path-to-Assets.xcassets>"
    echo "Example: ./copy-assets.sh ~/Desktop/HackathonStory/HackathonStory/Assets.xcassets"
    exit 1
fi

ASSETS_DIR="$1"
PLAYGROUND_DIR="../Hackathon.playground/Pages"

if [ ! -d "$ASSETS_DIR" ]; then
    echo "Error: Assets directory not found at $ASSETS_DIR"
    exit 1
fi

echo "📦 Copying images from playground to Xcode project..."
echo ""

# Function to copy image to asset catalog
copy_image() {
    local source=$1
    local name=$(basename "$source" .png)
    local dest="$ASSETS_DIR/${name}.imageset"

    if [ -f "$source" ]; then
        mkdir -p "$dest"
        cp "$source" "$dest/${name}.png"

        # Create Contents.json for the image
        cat > "$dest/Contents.json" << EOF
{
  "images" : [
    {
      "filename" : "${name}.png",
      "idiom" : "universal"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF
        echo "✅ Copied: $name"
    else
        echo "⚠️  Not found: $source"
    fi
}

# Copy images from IntroPage
echo "Intro Page images:"
copy_image "$PLAYGROUND_DIR/IntroPage.xcplaygroundpage/Resources/KonradHead.png"
copy_image "$PLAYGROUND_DIR/IntroPage.xcplaygroundpage/Resources/YaoHead.png"
copy_image "$PLAYGROUND_DIR/IntroPage.xcplaygroundpage/Resources/BlakeHead.png"
echo ""

# Copy images from FirstDayPage
echo "First Day images:"
copy_image "$PLAYGROUND_DIR/FirstDayPage.xcplaygroundpage/Resources/HackathonVenue.png"
copy_image "$PLAYGROUND_DIR/FirstDayPage.xcplaygroundpage/Resources/KonradMini.png"
copy_image "$PLAYGROUND_DIR/FirstDayPage.xcplaygroundpage/Resources/BlakeMini.png"
copy_image "$PLAYGROUND_DIR/FirstDayPage.xcplaygroundpage/Resources/YaoMini.png"
copy_image "$PLAYGROUND_DIR/FirstDayPage.xcplaygroundpage/Resources/Sun.png"
echo ""

# Copy images from SecondDayPage
echo "Second Day images:"
copy_image "$PLAYGROUND_DIR/SecondDayPage.xcplaygroundpage/Resources/ImacWithPlaygrounds.png"
copy_image "$PLAYGROUND_DIR/SecondDayPage.xcplaygroundpage/Resources/DarkBird.png"
copy_image "$PLAYGROUND_DIR/SecondDayPage.xcplaygroundpage/Resources/AppleMoon.png"
copy_image "$PLAYGROUND_DIR/SecondDayPage.xcplaygroundpage/Resources/BlakeBack.png"
copy_image "$PLAYGROUND_DIR/SecondDayPage.xcplaygroundpage/Resources/KonradBack.png"
copy_image "$PLAYGROUND_DIR/SecondDayPage.xcplaygroundpage/Resources/YaoBack.png"
echo ""

# Copy images from FinalDayPage
echo "Final Day images:"
copy_image "$PLAYGROUND_DIR/FinalDayPage.xcplaygroundpage/Resources/Konrad.png"
copy_image "$PLAYGROUND_DIR/FinalDayPage.xcplaygroundpage/Resources/Blake.png"
copy_image "$PLAYGROUND_DIR/FinalDayPage.xcplaygroundpage/Resources/Yao.png"
copy_image "$PLAYGROUND_DIR/FinalDayPage.xcplaygroundpage/Resources/Sweat.png"
copy_image "$PLAYGROUND_DIR/FinalDayPage.xcplaygroundpage/Resources/Timer.png"
echo ""

echo "🎉 Done! All images copied to $ASSETS_DIR"
echo ""
echo "Next steps:"
echo "1. Open your Xcode project"
echo "2. The images should now appear in Assets.xcassets"
echo "3. Build and run your app!"
