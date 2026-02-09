# Quick Start Checklist ✅

Follow this checklist to get your Hackathon Story app up and running!

## Prerequisites
- [ ] Xcode 15.0 or later installed
- [ ] macOS with Apple Silicon or Intel Mac
- [ ] Familiarity with Xcode basics

## Step 1: Create Xcode Project (5 minutes)
- [ ] Open Xcode
- [ ] Click "Create New Project"
- [ ] Select "iOS" > "App"
- [ ] Click "Next"
- [ ] Fill in project details:
  - [ ] Product Name: `HackathonStory`
  - [ ] Team: Your team or personal account
  - [ ] Organization Identifier: com.yourname (or your preference)
  - [ ] Interface: **SwiftUI**
  - [ ] Language: **Swift**
  - [ ] Storage: **None** (SwiftData not needed)
  - [ ] Include Tests: Optional
- [ ] Click "Next" and choose save location
- [ ] Click "Create"

## Step 2: Set Deployment Target (1 minute)
- [ ] Click on project name in navigator (top left)
- [ ] Select your app target
- [ ] Under "General" tab, find "Minimum Deployments"
- [ ] Set iOS to **17.0**

## Step 3: Organize Project Structure (2 minutes)
- [ ] In Xcode navigator, right-click on your app folder
- [ ] Select "New Group" and name it `Views`
- [ ] Create another "New Group" and name it `Helpers`

## Step 4: Add Swift Files (5 minutes)

### Main Files
- [ ] Delete the default `ContentView.swift` if asked to replace
- [ ] Drag `WWDCApp/ContentView.swift` into your project
  - [ ] Check "Copy items if needed"
  - [ ] Ensure target is selected
- [ ] Rename `WWDCAppApp.swift` to match your project name
  - [ ] Or copy its contents to your existing app file

### Views Folder
Drag these files into the `Views` group:
- [ ] `Views/IntroView.swift`
- [ ] `Views/FirstDayView.swift`
- [ ] `Views/SecondDayView.swift`
- [ ] `Views/FinalDayView.swift`
- [ ] `Views/LastView.swift`

### Helpers Folder
- [ ] `Helpers/AudioNarrator.swift`

## Step 5: Add Images (10-15 minutes)

### Option A: Using the Script (Recommended)
```bash
cd WWDCApp
./copy-assets.sh ~/path/to/YourXcodeProject/HackathonStory/Assets.xcassets
```
- [ ] Open Terminal
- [ ] Navigate to WWDCApp folder
- [ ] Run the copy-assets.sh script with your project path
- [ ] Verify images appear in Xcode's Assets.xcassets

### Option B: Manual Copy
Open these folders in Finder and drag images to Assets.xcassets:

**From IntroPage Resources:**
- [ ] KonradHead.png
- [ ] YaoHead.png
- [ ] BlakeHead.png

**From FirstDayPage Resources:**
- [ ] HackathonVenue.png
- [ ] KonradMini.png
- [ ] BlakeMini.png
- [ ] YaoMini.png
- [ ] Sun.png

**From SecondDayPage Resources:**
- [ ] ImacWithPlaygrounds.png
- [ ] DarkBird.png
- [ ] AppleMoon.png
- [ ] BlakeBack.png
- [ ] KonradBack.png
- [ ] YaoBack.png

**From FinalDayPage Resources:**
- [ ] Konrad.png
- [ ] Blake.png
- [ ] Yao.png
- [ ] Sweat.png

## Step 6: Build the Project (2 minutes)
- [ ] Select a simulator (iOS 17.0+) from the scheme selector
  - Recommended: iPhone 15 Pro
- [ ] Press **Cmd + B** to build
- [ ] Check for any build errors (there shouldn't be any!)
- [ ] If errors appear, check:
  - [ ] All files are added to target
  - [ ] All images are in Assets.xcassets
  - [ ] Deployment target is iOS 17.0+

## Step 7: Run the App! 🎉
- [ ] Press **Cmd + R** or click the Play button
- [ ] Wait for simulator to launch
- [ ] App should open showing the Intro page
- [ ] Try swiping left to go to the next page
- [ ] Listen for audio narration (may need to enable simulator audio)
- [ ] Navigate through all 5 pages

## Step 8: Test Features
- [ ] **Swipe Navigation**: Swipe left/right between pages
- [ ] **Chevron Buttons**: Tap the left/right chevron buttons
- [ ] **Audio Narration**: Each page should speak when it appears
- [ ] **Animations**: Check that animations play smoothly
  - [ ] Intro: Pulsing text
  - [ ] Day 1: Speech bubbles appear
  - [ ] Day 2: Day/night transition, birds flying
  - [ ] Final Day: Countdown timer, sweat drops
  - [ ] Last Page: Text slides down, heads rotate

## Troubleshooting Checklist

### Build Errors
- [ ] Clean build folder: **Product** > **Clean Build Folder** (Shift+Cmd+K)
- [ ] Restart Xcode
- [ ] Check all files have correct target membership
- [ ] Verify iOS deployment target is 17.0+

### Images Not Showing
- [ ] Open Assets.xcassets and verify all images are there
- [ ] Check image names match exactly (case-sensitive)
- [ ] Ensure images are universal (not device-specific)

### No Audio
- [ ] Check simulator volume (Hardware > Audio)
- [ ] Try on a physical device
- [ ] Verify `import AVFoundation` in AudioNarrator.swift

### Layout Issues
- [ ] Test on different simulator sizes (iPhone 15, iPhone SE)
- [ ] Check both portrait and landscape
- [ ] Adjust spacing/padding if needed

## Optional Enhancements

Once everything works, consider:
- [ ] Add custom app icon
- [ ] Customize colors/fonts
- [ ] Add haptic feedback
- [ ] Optimize for iPad
- [ ] Add accessibility labels
- [ ] Implement dark mode support

## Success Criteria ✅

Your app is ready when:
- ✅ All 5 pages display correctly
- ✅ Swipe navigation works smoothly
- ✅ Audio narration plays on each page
- ✅ Animations run without glitches
- ✅ No build warnings or errors
- ✅ App runs on iOS 17+ simulators/devices

## Time Estimate
- **Minimum**: 20-25 minutes (if everything goes smoothly)
- **Average**: 30-40 minutes (with some troubleshooting)
- **Maximum**: 60 minutes (if you customize along the way)

---

**Got stuck?** Check the detailed guides:
- [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) - Step-by-step setup
- [CONVERSION_SUMMARY.md](CONVERSION_SUMMARY.md) - Technical details
- [README.md](README.md) - Project overview

**Have fun building your hackathon story app!** 🚀
