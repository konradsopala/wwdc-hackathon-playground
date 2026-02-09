//
//  HKIntroViewController.h
//  Hackathon Story
//
//  Objective-C conversion of IntroView
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The introduction page of the hackathon story.
 *
 * This view controller presents the opening scene with:
 * - An orange background
 * - Pulsing "Once upon a time..." text
 * - Three character heads (Konrad, Yao, Blake) with slide-in animation
 * - Audio narration introducing the story
 *
 * The view controller automatically starts animations and narration when it appears,
 * and properly cleans up audio when it disappears.
 */
@interface HKIntroViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
