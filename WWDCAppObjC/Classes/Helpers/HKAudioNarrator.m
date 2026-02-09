//
//  HKAudioNarrator.m
//  Hackathon Story
//
//  Objective-C conversion of AudioNarrator
//

#import "HKAudioNarrator.h"

@interface HKAudioNarrator () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, assign, readwrite) BOOL isSpeaking;

@end

@implementation HKAudioNarrator

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate = self;
        _isSpeaking = NO;
    }
    return self;
}

#pragma mark - Public Methods

- (void)speak:(NSString *)text {
    [self speak:text language:@"en-US" rate:AVSpeechUtteranceDefaultSpeechRate];
}

- (void)speak:(NSString *)text language:(NSString *)language {
    [self speak:text language:language rate:AVSpeechUtteranceDefaultSpeechRate];
}

- (void)speak:(NSString *)text language:(NSString *)language rate:(float)rate {
    // Stop any ongoing speech
    if (self.synthesizer.isSpeaking) {
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }

    // Create and configure the utterance
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    utterance.rate = rate;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:language];

    // Speak the utterance (isSpeaking will be set by didStartSpeechUtterance: delegate)
    [self.synthesizer speakUtterance:utterance];
}

- (void)stop {
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    self.isSpeaking = NO;
}

#pragma mark - AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.isSpeaking = YES;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.isSpeaking = NO;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    self.isSpeaking = NO;
}

@end
