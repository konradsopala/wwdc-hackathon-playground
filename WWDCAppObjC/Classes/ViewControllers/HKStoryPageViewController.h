//
//  HKStoryPageViewController.h
//  Hackathon Story
//
//  Main container for page-based story navigation
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The main container view controller that provides page-based navigation through the hackathon story.
 *
 * Uses UIPageViewController to create a swipeable storybook experience.
 * Users can navigate between pages by:
 * - Swiping left or right
 * - Using page indicator dots
 *
 * The view controller manages 5 story pages:
 * 1. Intro - Introduction to the characters
 * 2. First Day - Arrival at the hackathon
 * 3. Second Day - Coding through day and night
 * 4. Final Day - Waiting for results
 * 5. Last Page - Conclusion
 */
@interface HKStoryPageViewController : UIPageViewController

@end

NS_ASSUME_NONNULL_END
