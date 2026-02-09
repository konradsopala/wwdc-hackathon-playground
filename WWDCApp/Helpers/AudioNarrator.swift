import AVFoundation
import SwiftUI

/// A helper class that provides text-to-speech narration capabilities using AVFoundation.
///
/// `AudioNarrator` wraps `AVSpeechSynthesizer` to provide a simple, reusable interface for
/// adding audio narration to SwiftUI views. It manages the speech lifecycle and provides
/// observable state for tracking when speech is active.
///
/// ## Usage
/// ```swift
/// @State private var narrator = AudioNarrator()
///
/// narrator.speak("Hello, world!")
/// ```
///
/// - Note: Text-to-speech does not require microphone permissions as it only produces audio output.
@Observable
class AudioNarrator {
    /// The underlying speech synthesizer from AVFoundation
    private let synthesizer = AVSpeechSynthesizer()

    /// Indicates whether the narrator is currently speaking
    /// This property is observable and can be used to trigger UI updates
    private(set) var isSpeaking = false

    /// Speaks the provided text using text-to-speech synthesis.
    ///
    /// This method will automatically stop any ongoing speech before starting the new utterance.
    /// The `isSpeaking` property will be updated to reflect the speaking state.
    ///
    /// - Parameters:
    ///   - text: The text to be spoken
    ///   - language: The language code for the voice (default: "en-US")
    ///   - rate: The speaking rate (default: system default rate)
    ///
    /// ## Example
    /// ```swift
    /// narrator.speak("Welcome to the hackathon!")
    /// narrator.speak("Bienvenue!", language: "fr-FR")
    /// ```
    func speak(_ text: String, language: String = "en-US", rate: Float = AVSpeechUtteranceDefaultSpeechRate) {
        // Stop any ongoing speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = rate
        utterance.voice = AVSpeechSynthesisVoice(language: language)

        isSpeaking = true
        synthesizer.speak(utterance)

        // Monitor when speech finishes
        // Note: This is an approximation based on text length
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) / 10) {
            self.isSpeaking = false
        }
    }

    /// Immediately stops any ongoing speech synthesis.
    ///
    /// Call this method when you need to interrupt narration, such as when
    /// navigating away from a view or when the user requests silence.
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}
