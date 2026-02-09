//
//  HKIntroViewController.m
//  Hackathon Story
//
//  Objective-C conversion of IntroView
//

#import "HKIntroViewController.h"
#import "HKAudioNarrator.h"

@interface HKIntroViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *konradHeadImageView;
@property (nonatomic, strong) UIImageView *yaoHeadImageView;
@property (nonatomic, strong) UIImageView *blakeHeadImageView;
@property (nonatomic, strong) UIView *headsContainerView;
@property (nonatomic, strong) HKAudioNarrator *narrator;

@end

@implementation HKIntroViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupSubviews];

    self.narrator = [[HKAudioNarrator alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startAnimations];
    [self.narrator speak:@"Once upon a time there was a lot of students who were doing their best to get scholarships to Dub-Dub in San Jose"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.narrator stop];
}

#pragma mark - Setup

- (void)setupView {
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)setupSubviews {
    // Title label
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"Once upon a time...";
    self.titleLabel.font = [UIFont systemFontOfSize:48 weight:UIFontWeightHeavy];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.alpha = 0.0;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];

    // Container for heads (for easier animation)
    self.headsContainerView = [[UIView alloc] init];
    self.headsContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.headsContainerView];

    // Character heads
    self.konradHeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KonradHead"]];
    self.konradHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.konradHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;

    self.yaoHeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YaoHead"]];
    self.yaoHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.yaoHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;

    self.blakeHeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlakeHead"]];
    self.blakeHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.blakeHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.headsContainerView addSubview:self.konradHeadImageView];
    [self.headsContainerView addSubview:self.yaoHeadImageView];
    [self.headsContainerView addSubview:self.blakeHeadImageView];

    // Layout constraints
    [NSLayoutConstraint activateConstraints:@[
        // Title label
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:100],
        [self.titleLabel.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.titleLabel.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-20],

        // Heads container
        [self.headsContainerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.headsContainerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50],
        [self.headsContainerView.heightAnchor constraintEqualToConstant:120],

        // Konrad head
        [self.konradHeadImageView.leadingAnchor constraintEqualToAnchor:self.headsContainerView.leadingAnchor],
        [self.konradHeadImageView.centerYAnchor constraintEqualToAnchor:self.headsContainerView.centerYAnchor],
        [self.konradHeadImageView.widthAnchor constraintEqualToConstant:120],
        [self.konradHeadImageView.heightAnchor constraintEqualToConstant:120],

        // Yao head
        [self.yaoHeadImageView.leadingAnchor constraintEqualToAnchor:self.konradHeadImageView.trailingAnchor constant:80],
        [self.yaoHeadImageView.centerYAnchor constraintEqualToAnchor:self.headsContainerView.centerYAnchor],
        [self.yaoHeadImageView.widthAnchor constraintEqualToConstant:120],
        [self.yaoHeadImageView.heightAnchor constraintEqualToConstant:120],

        // Blake head
        [self.blakeHeadImageView.leadingAnchor constraintEqualToAnchor:self.yaoHeadImageView.trailingAnchor constant:80],
        [self.blakeHeadImageView.trailingAnchor constraintEqualToAnchor:self.headsContainerView.trailingAnchor],
        [self.blakeHeadImageView.centerYAnchor constraintEqualToAnchor:self.headsContainerView.centerYAnchor],
        [self.blakeHeadImageView.widthAnchor constraintEqualToConstant:120],
        [self.blakeHeadImageView.heightAnchor constraintEqualToConstant:120],
    ]];

    // Set initial position for slide-in animation
    self.headsContainerView.transform = CGAffineTransformMakeTranslation(-300, 0);
}

#pragma mark - Animations

- (void)startAnimations {
    [self animatePulsingText];
    [self animateHeadsSlideIn];
}

- (void)animatePulsingText {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.titleLabel.alpha = 1.0;
    } completion:nil];
}

- (void)animateHeadsSlideIn {
    [UIView animateWithDuration:7.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.headsContainerView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
