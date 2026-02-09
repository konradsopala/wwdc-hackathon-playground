//
//  AppDelegate.m
//  Hackathon Story
//
//  Objective-C UIKit version
//

#import "AppDelegate.h"
#import "HKStoryPageViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Create window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // Create and set root view controller
    HKStoryPageViewController *storyPageVC = [[HKStoryPageViewController alloc] init];
    self.window.rootViewController = storyPageVC;

    // Make window visible
    [self.window makeKeyAndVisible];

    return YES;
}

@end
