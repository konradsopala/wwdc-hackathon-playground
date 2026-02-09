import SwiftUI

/// The final page of the hackathon story showing the conclusion.
///
/// This view features:
/// - An orange background matching the intro
/// - "To be continued..." text that slides down from above
/// - Three character heads that rotate continuously
/// - Audio narration about the story of anticipation
/// - A sense of closure while hinting at future developments
struct LastView: View {
    /// Vertical offset for the sliding text animation
    @State private var textOffset: CGFloat = -400

    /// Rotation angle in degrees for the spinning character heads
    @State private var rotationDegrees = 0.0

    /// Audio narrator instance for text-to-speech
    @State private var narrator = AudioNarrator()

    var body: some View {
        ZStack {
            // Orange background
            Color.orange
                .ignoresSafeArea()

            VStack(spacing: 100) {
                // Animated "To be continued..." text
                Text("To be continued...")
                    .font(.system(size: 48, weight: .heavy))
                    .foregroundStyle(.white)
                    .offset(y: textOffset)

                // Rotating character heads
                HStack(spacing: 80) {
                    Image("KonradHead")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(rotationDegrees))

                    Image("YaoHead")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(rotationDegrees))

                    Image("BlakeHead")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(rotationDegrees))
                }

                Spacer()
            }
        }
        .onAppear {
            startAnimations()
            // Delayed narration
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                narrator.speak("Here starts the story of great anticipation")
            }
        }
        .onDisappear {
            narrator.stop()
        }
    }

    /// Starts the conclusion animations in sequence.
    ///
    /// Coordinates two animations:
    /// 1. The "To be continued..." text slides down from off-screen
    /// 2. After a 1.5 second delay, the character heads begin rotating continuously
    private func startAnimations() {
        // Slide down the "To be continued..." text
        withAnimation(.easeOut(duration: 2.0)) {
            textOffset = 100
        }

        // Start rotating heads after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                rotationDegrees = 360
            }
        }
    }
}

#Preview {
    LastView()
}
