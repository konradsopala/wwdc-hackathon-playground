//
//  HKAudioNarrator.h
//  Hackathon Story
//
//  Objective-C conversion of AudioNarrator
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A helper class that provides text-to-speech narration capabilities using AVFoundation.
 *
 * `HKAudioNarrator` wraps `AVSpeechSynthesizer` to provide a simple, reusable interface for
 * adding audio narration to UIKit views. It manages the speech lifecycle and provides
 * KVO-compatible properties for tracking when speech is active.
 *
 * ## Usage
 * ```objective-c
 * HKAudioNarrator *narrator = [[HKAudioNarrator alloc] init];
 * [narrator speak:@"Hello, world!"];
 * ```
 *
 * @note Text-to-speech does not require microphone permissions as it only produces audio output.
 */
@interface HKAudioNarrator : NSObject

/**
 * Indicates whether the narrator is currently speaking.
 * This property is KVO-compliant and can be observed for state changes.
 */
@property (nonatomic, assign, readonly) BOOL isSpeaking;

/**
 * Speaks the provided text using text-to-speech synthesis.
 *
 * This method will automatically stop any ongoing speech before starting the new utterance.
 * The `isSpeaking` property will be updated to reflect the speaking state.
 *
 * @param text The text to be spoken
 */
- (void)speak:(NSString *)text;

/**
 * Speaks the provided text using text-to-speech synthesis with custom language.
 *
 * @param text The text to be spoken
 * @param language The language code for the voice (e.g., "en-US", "fr-FR")
 */
- (void)speak:(NSString *)text language:(NSString *)language;

/**
 * Speaks the provided text using text-to-speech synthesis with full customization.
 *
 * @param text The text to be spoken
 * @param language The language code for the voice (default: "en-US")
 * @param rate The speaking rate (default: AVSpeechUtteranceDefaultSpeechRate)
 */
- (void)speak:(NSString *)text language:(NSString *)language rate:(float)rate;

/**
 * Immediately stops any ongoing speech synthesis.
 *
 * Call this method when you need to interrupt narration, such as when
 * navigating away from a view or when the user requests silence.
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
