import AVFoundation
import SwiftUI

/// Helper class for audio narration using AVSpeechSynthesizer
@Observable
class AudioNarrator {
    private let synthesizer = AVSpeechSynthesizer()
    private(set) var isSpeaking = false

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
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) / 10) {
            self.isSpeaking = false
        }
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}
