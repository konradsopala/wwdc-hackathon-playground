import SwiftUI
import AVFoundation

/// Last Page - "To be continued..." ending
public struct LastPageView: View {
    @State private var labelOffset: CGFloat = -400
    @State private var rotationAngle: Double = 0
    @State private var speechSynthesizer = AVSpeechSynthesizer()

    private let headsSize: CGFloat = 120

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.orange
                    .ignoresSafeArea()

                // "To be continued" label
                Text("To be continued...")
                    .font(.custom("Avenir-Heavy", size: 48))
                    .foregroundStyle(.white)
                    .offset(y: labelOffset)

                // Rotating hacker heads
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: headsSize, height: headsSize)
                    .foregroundStyle(.blue)
                    .rotationEffect(.degrees(rotationAngle))
                    .position(x: 100, y: geometry.size.height * 0.3)

                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: headsSize, height: headsSize)
                    .foregroundStyle(.green)
                    .rotationEffect(.degrees(rotationAngle))
                    .position(x: geometry.size.width - 100, y: geometry.size.height * 0.3)

                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: headsSize, height: headsSize)
                    .foregroundStyle(.purple)
                    .rotationEffect(.degrees(rotationAngle))
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.65)

                // Credits
                VStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Text("Created for WWDC 2018 Scholarship")
                            .font(.custom("Avenir-Heavy", size: 16))
                            .foregroundStyle(.white.opacity(0.8))

                        Text("Converted to SwiftUI")
                            .font(.custom("Avenir-Heavy", size: 14))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .padding(.bottom, 80)
                }
            }
        }
        .onAppear {
            animateLabel()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                tellStory()
                rotateHeads()
            }
        }
    }

    private func animateLabel() {
        withAnimation(.easeOut(duration: 2.0)) {
            labelOffset = 0
        }
    }

    private func rotateHeads() {
        withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }

    private func tellStory() {
        let storyText = AVSpeechUtterance(string: "Here starts the story of great anticipation")
        storyText.rate = AVSpeechUtteranceDefaultSpeechRate
        storyText.voice = AVSpeechSynthesisVoice(language: "en-US")

        if !speechSynthesizer.isSpeaking {
            speechSynthesizer.speak(storyText)
        }
    }
}

#Preview {
    LastPageView()
}
