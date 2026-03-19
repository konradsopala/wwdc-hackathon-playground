import SwiftUI
import AVFoundation

/// Introduction page - "Once upon a time..."
/// Displays animated hacker heads converging together
public struct IntroPageView: View {
    @State private var introLabelOpacity: Double = 0
    @State private var konradOffset: CGFloat = 0
    @State private var yaoOffset: CGFloat = 0
    @State private var speechSynthesizer = AVSpeechSynthesizer()

    private let headsSize: CGFloat = 120

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.orange
                    .ignoresSafeArea()

                // Intro label
                Text("Once upon a time...")
                    .font(.custom("Avenir-Heavy", size: 48))
                    .foregroundStyle(.white)
                    .opacity(introLabelOpacity)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                // Konrad head - starts left, moves right
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: headsSize, height: headsSize)
                    .foregroundStyle(.blue)
                    .position(x: 80 + konradOffset, y: geometry.size.height * 0.3)

                // Yao head - starts right, moves left
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: headsSize, height: headsSize)
                    .foregroundStyle(.green)
                    .position(x: geometry.size.width - 80 + yaoOffset, y: geometry.size.height * 0.3)

                // Blake head - center bottom
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: headsSize, height: headsSize)
                    .foregroundStyle(.purple)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.65)

                // Story description
                VStack {
                    Spacer()
                    Text("Hackathon Playground")
                        .font(.custom("Avenir-Heavy", size: 24))
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.bottom, 60)
                }
            }
        }
        .onAppear {
            animateIntroLabel()
            animateHackerHeads()
            tellStory()
        }
    }

    private func animateIntroLabel() {
        withAnimation(.easeIn(duration: 1.0)) {
            introLabelOpacity = 1.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeOut(duration: 1.0)) {
                introLabelOpacity = 0
            }
        }
    }

    private func animateHackerHeads() {
        withAnimation(.easeInOut(duration: 7.0)) {
            konradOffset = 150
            yaoOffset = -150
        }
    }

    private func tellStory() {
        let storyText = AVSpeechUtterance(string: "Once upon a time there was a lot of students who were doing their best to get scholarships to Dub-Dub in San Jose")
        storyText.rate = AVSpeechUtteranceDefaultSpeechRate
        storyText.voice = AVSpeechSynthesisVoice(language: "en-US")

        if !speechSynthesizer.isSpeaking {
            speechSynthesizer.speak(storyText)
        }
    }
}

#Preview {
    IntroPageView()
}
