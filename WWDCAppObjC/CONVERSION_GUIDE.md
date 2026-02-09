# SwiftUI to Objective-C UIKit Conversion Guide

This document explains how the modern SwiftUI app was converted to classic Objective-C UIKit.

## 📊 Conversion Overview

| Aspect | SwiftUI Version | Objective-C UIKit Version |
|--------|----------------|---------------------------|
| **Language** | Swift 5.x | Objective-C |
| **UI Framework** | SwiftUI | UIKit |
| **Min iOS** | iOS 17.0 | iOS 12.0 |
| **Architecture** | MVVM-like | MVC |
| **State** | @State, @Observable | Properties + KVO |
| **Layout** | Declarative DSL | Programmatic Auto Layout |
| **Navigation** | TabView (.page) | UIPageViewController |
| **Animations** | withAnimation() | UIView animate blocks |

## 🔄 File-by-File Conversion

### 1. AudioNarrator.swift → HKAudioNarrator.h/m

**SwiftUI (Swift):**
```swift
@Observable
class AudioNarrator {
    private let synthesizer = AVSpeechSynthesizer()
    private(set) var isSpeaking = false

    func speak(_ text: String) { ... }
    func stop() { ... }
}
```

**UIKit (Objective-C):**
```objective-c
// HKAudioNarrator.h
@interface HKAudioNarrator : NSObject
@property (nonatomic, assign, readonly) BOOL isSpeaking;
- (void)speak:(NSString *)text;
- (void)stop;
@end

// HKAudioNarrator.m
@implementation HKAudioNarrator
// Implements AVSpeechSynthesizerDelegate for proper state tracking
@end
```

**Key Changes:**
- `@Observable` → Manual KVO compliance
- Swift class → Objective-C class with .h/.m files
- Swift closures → Delegate pattern
- Property observers → Explicit setter calls

### 2. IntroView.swift → HKIntroViewController.h/m

**SwiftUI (Swift):**
```swift
struct IntroView: View {
    @State private var textOpacity: Double = 0
    @State private var headsOffset: CGFloat = -300
    @State private var narrator = AudioNarrator()

    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                Text("Once upon a time...")
                    .opacity(textOpacity)
                HStack { /* character heads */ }
                    .offset(x: headsOffset)
            }
        }
        .onAppear { startAnimations() }
    }
}
```

**UIKit (Objective-C):**
```objective-c
@interface HKIntroViewController : UIViewController
@end

@implementation HKIntroViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Create and layout subviews with Auto Layout
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startAnimations];
    [self.narrator speak:@"..."];
}
@end
```

**Key Changes:**
- `struct` → `@interface/@implementation`
- `View` protocol → `UIViewController` subclass
- `@State` → `@property`
- `body` → `viewDidLoad` + `viewDidAppear`
- SwiftUI modifiers → UIView properties
- `.onAppear` → `viewDidAppear:`
- Declarative layout → Imperative Auto Layout

### 3. ContentView.swift → HKStoryPageViewController.h/m

**SwiftUI (Swift):**
```swift
struct ContentView: View {
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            IntroView().tag(0)
            FirstDayView().tag(1)
            // ...
        }
        .tabViewStyle(.page)
    }
}
```

**UIKit (Objective-C):**
```objective-c
@interface HKStoryPageViewController : UIPageViewController
<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@end

@implementation HKStoryPageViewController
- (void)setupPages {
    self.pages = @[introVC, firstDayVC, ...];
    [self setViewControllers:@[self.pages[0]] ...];
}
// Implement data source methods
@end
```

**Key Changes:**
- `TabView` → `UIPageViewController`
- `@State` binding → `NSInteger` property
- Automatic page management → Manual data source
- `.tag()` → Array indexing

## 🎨 Animation Conversion

### SwiftUI Animation
```swift
withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
    textOpacity = 1.0
}
```

### UIKit Animation
```objective-c
[UIView animateWithDuration:1.0
                      delay:0.0
                    options:UIViewAnimationOptionRepeat |
                           UIViewAnimationOptionAutoreverse |
                           UIViewAnimationOptionCurveEaseInOut
                 animations:^{
    self.titleLabel.alpha = 1.0;
} completion:nil];
```

## 📐 Layout Conversion

### SwiftUI Layout
```swift
VStack(spacing: 100) {
    Text("Title")
        .font(.system(size: 48, weight: .heavy))
    HStack(spacing: 80) {
        Image("KonradHead")
            .frame(width: 120, height: 120)
    }
}
```

### UIKit Layout
```objective-c
UILabel *label = [[UILabel alloc] init];
label.font = [UIFont systemFontOfSize:48 weight:UIFontWeightHeavy];
label.translatesAutoresizingMaskIntoConstraints = NO;
[self.view addSubview:label];

[NSLayoutConstraint activateConstraints:@[
    [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    [label.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
]];
```

## 🔧 Memory Management

### SwiftUI (ARC)
```swift
@State private var narrator = AudioNarrator()  // Automatic cleanup

.onDisappear {
    narrator.stop()
}
```

### Objective-C (ARC)
```objective-c
@property (nonatomic, strong) HKAudioNarrator *narrator;  // strong reference

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.narrator stop];  // Explicit cleanup
}
```

## 🎯 Architectural Patterns

### SwiftUI: Declarative + Reactive
- Views are structs (value types)
- State changes automatically update UI
- Functional, declarative style
- Combine framework for reactivity

### UIKit: Imperative + MVC
- Views are classes (reference types)
- Manual UI updates required
- Procedural, imperative style
- Delegation for callbacks

## 📝 Best Practices Applied

### Objective-C UIKit Version

✅ **Proper Headers**: Clean separation of interface (.h) and implementation (.m)
✅ **Auto Layout**: Modern constraint-based layout
✅ **ARC**: Automatic memory management
✅ **Delegation**: AVSpeechSynthesizerDelegate for state tracking
✅ **KVO-Compliant**: Properties follow KVO conventions
✅ **Documentation**: HeaderDoc comments throughout
✅ **Naming**: HK prefix to avoid namespace collisions

## 🚀 Extending the Conversion

To complete the conversion, follow these patterns:

### 1. Create View Controller Header
```objective-c
// HKFirstDayViewController.h
#import <UIKit/UIKit.h>

@interface HKFirstDayViewController : UIViewController
@end
```

### 2. Implement View Controller
```objective-c
// HKFirstDayViewController.m
#import "HKFirstDayViewController.h"
#import "HKAudioNarrator.h"

@interface HKFirstDayViewController ()
@property (nonatomic, strong) HKAudioNarrator *narrator;
@property (nonatomic, strong) UIImageView *venueImageView;
// ... other properties
@end

@implementation HKFirstDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startAnimations];
    [self.narrator speak:@"Narration text"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.narrator stop];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubviews {
    // Create UI elements
    // Set up Auto Layout constraints
}

- (void)startAnimations {
    // UIView animations
}

@end
```

### 3. Add to Page Controller
```objective-c
// In HKStoryPageViewController.m
#import "HKFirstDayViewController.h"

- (void)setupPages {
    HKIntroViewController *introVC = [[HKIntroViewController alloc] init];
    HKFirstDayViewController *firstDayVC = [[HKFirstDayViewController alloc] init];
    // ...

    self.pages = @[introVC, firstDayVC, ...];
}
```

## 📚 Learning Resources

### Objective-C & UIKit
- [Objective-C Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/)
- [UIKit Documentation](https://developer.apple.com/documentation/uikit)
- [Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/)

### Migration Guides
- [UIKit to SwiftUI](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)
- [SwiftUI to UIKit](https://www.hackingwithswift.com/quick-start/swiftui/how-to-wrap-a-custom-uiview-for-swiftui)

---

**Why This Conversion Matters:**

This conversion demonstrates how modern SwiftUI concepts map to classic UIKit patterns. Understanding both approaches helps developers:
- **Maintain legacy codebases** written in Objective-C
- **Bridge SwiftUI and UIKit** in mixed projects
- **Appreciate framework evolution** from imperative to declarative
- **Choose the right tool** for the job

The Objective-C version runs on older devices (iOS 12+) and uses time-tested patterns that power millions of apps! 🚀
