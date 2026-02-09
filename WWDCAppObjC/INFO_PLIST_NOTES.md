# Info.plist Configuration Notes

## About Info.plist.template

The provided `Info.plist.template` is configured for **fully programmatic UI** without storyboards.

## Key Configuration Details

### ✅ What's Included

```xml
<key>CFBundleExecutable</key>
<string>$(EXECUTABLE_NAME)</string>

<key>UIApplicationSceneManifest</key>
<dict>
    <key>UIApplicationSupportsMultipleScenes</key>
    <false/>
</dict>

<key>UIRequiredDeviceCapabilities</key>
<array>
    <string>arm64</string>  <!-- Modern devices only -->
</array>
```

### ❌ What's NOT Included (Intentional)

**No Main Storyboard:**
```xml
<!-- NOT included - app uses programmatic UI -->
<key>UIMainStoryboardFile</key>
<string>Main</string>
```

**No Launch Screen Storyboard:**
```xml
<!-- NOT included by default - see instructions below to add -->
<key>UILaunchStoryboardName</key>
<string>LaunchScreen</string>
```

## Why No Storyboards?

This app demonstrates **100% programmatic UI**:
- ✅ All views created in code
- ✅ Auto Layout with NSLayoutConstraint
- ✅ No Interface Builder dependencies
- ✅ Better for learning UIKit fundamentals
- ✅ Easier version control (no XML merge conflicts)

## Adding a Launch Screen (Optional)

If you want a launch screen instead of a blank white screen during app startup:

### Option 1: Create Launch Screen Storyboard

1. In Xcode: **File > New > File**
2. Choose **Launch Screen** under iOS
3. Name it `LaunchScreen.storyboard`
4. Add to your target
5. Add to Info.plist:
   ```xml
   <key>UILaunchStoryboardName</key>
   <string>LaunchScreen</string>
   ```

### Option 2: Use Launch Images (Legacy)

1. Add launch images to Assets.xcassets
2. Configure in Project Settings > App Icons and Launch Images

### Option 3: Accept Default Behavior

- iOS shows a blank screen briefly before AppDelegate loads
- For a simple app like this, it's perfectly acceptable

## Using the Template

### In a New Xcode Project:

1. Create new iOS App project in Xcode
2. Delete the default `Info.plist`
3. Copy `Info.plist.template` to your project
4. Rename to `Info.plist`
5. Build and run!

### Modifying Existing Info.plist:

Remove these keys if present:
- `UIMainStoryboardFile`
- `UILaunchStoryboardName`
- `Main storyboard file base name`
- `Launch screen interface file base name`

## Troubleshooting

**Warning: "Could not find LaunchScreen.storyboard"**
- This is expected with programmatic UI
- The warning is harmless
- To suppress: Ensure `UILaunchStoryboardName` is not in Info.plist

**App shows black screen on launch**
- Check `AppDelegate.m` creates the window:
  ```objective-c
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = /* your view controller */;
  [self.window makeKeyAndVisible];
  ```

**Build error: "Main.storyboard not found"**
- Remove `UIMainStoryboardFile` from Info.plist
- Clear build folder: Shift+Cmd+K

## Reference: Complete Info.plist Template

The complete template is available in `Info.plist.template` with:
- ✅ Programmatic UI configuration
- ✅ Comments explaining optional keys
- ✅ Modern arm64 device support
- ✅ Standard orientation support
- ✅ No storyboard dependencies

## Summary

| Feature | Status | Notes |
|---------|--------|-------|
| Main Storyboard | ❌ Not used | Programmatic UI |
| Launch Screen | ⚠️ Optional | Can add if desired |
| Programmatic Window | ✅ Required | Created in AppDelegate |
| Scene Manifest | ✅ Included | iOS 13+ compatibility |
| Device Support | ✅ arm64 | Modern devices |

---

**Remember:** This configuration is intentional and demonstrates classic iOS development without Interface Builder! 🎯
