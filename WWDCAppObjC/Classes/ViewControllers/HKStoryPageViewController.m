//
//  HKStoryPageViewController.m
//  Hackathon Story
//
//  Main container for page-based story navigation
//

#import "HKStoryPageViewController.h"
#import "HKIntroViewController.h"

@interface HKStoryPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray<UIViewController *> *pages;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation HKStoryPageViewController

#pragma mark - View Lifecycle

- (instancetype)init {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                  options:nil];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPages];
    [self setupInitialPage];
}

#pragma mark - Setup

- (void)setupPages {
    // Create all page view controllers
    HKIntroViewController *introVC = [[HKIntroViewController alloc] init];

    // Create placeholder view controllers for other pages
    UIViewController *firstDayVC = [self createPlaceholderVCWithTitle:@"Day 1" color:[UIColor whiteColor] textColor:[UIColor blackColor]];
    UIViewController *secondDayVC = [self createPlaceholderVCWithTitle:@"Day 2" color:[UIColor colorWithRed:0.00 green:0.67 blue:0.54 alpha:1.0] textColor:[UIColor whiteColor]];
    UIViewController *finalDayVC = [self createPlaceholderVCWithTitle:@"Final Day" color:[UIColor colorWithRed:0.73 green:0.44 blue:0.44 alpha:1.0] textColor:[UIColor whiteColor]];
    UIViewController *lastVC = [self createPlaceholderVCWithTitle:@"To be continued..." color:[UIColor orangeColor] textColor:[UIColor whiteColor]];

    self.pages = @[introVC, firstDayVC, secondDayVC, finalDayVC, lastVC];
}

- (void)setupInitialPage {
    if (self.pages.count > 0) {
        [self setViewControllers:@[self.pages[0]]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:nil];
        self.currentPageIndex = 0;
    }
}

- (UIViewController *)createPlaceholderVCWithTitle:(NSString *)title color:(UIColor *)backgroundColor textColor:(UIColor *)textColor {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = backgroundColor;

    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:36 weight:UIFontWeightBold];
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [vc.view addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:vc.view.centerXAnchor],
        [label.centerYAnchor constraintEqualToAnchor:vc.view.centerYAnchor],
        [label.leadingAnchor constraintGreaterThanOrEqualToAnchor:vc.view.leadingAnchor constant:20],
        [label.trailingAnchor constraintLessThanOrEqualToAnchor:vc.view.trailingAnchor constant:-20],
    ]];

    return vc;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return self.pages[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == NSNotFound || index == self.pages.count - 1) {
        return nil;
    }
    return self.pages[index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.pages.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.currentPageIndex;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed) {
        UIViewController *currentVC = pageViewController.viewControllers.firstObject;
        if (currentVC && self.pages) {
            NSUInteger idx = [self.pages indexOfObject:currentVC];
            if (idx != NSNotFound) {
                self.currentPageIndex = (NSInteger)idx;
            }
        }
    }
}

@end
