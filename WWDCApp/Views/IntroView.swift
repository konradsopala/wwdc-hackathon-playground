import SwiftUI

/// The introduction page of the hackathon story.
///
/// This view presents the opening scene with:
/// - An orange background
/// - Pulsing "Once upon a time..." text
/// - Three character heads (Konrad, Yao, Blake) with subtle animation
/// - Audio narration introducing the story
///
/// The view automatically starts animations and narration when it appears,
/// and properly cleans up audio when it disappears.
struct IntroView: View {
    /// Opacity value for the pulsing title text animation
    @State private var textOpacity: Double = 0

    /// Horizontal offset for the character heads animation
    /// Starts off-screen to the left and animates to center position
    @State private var headsOffset: CGFloat = -300

    /// Audio narrator instance for text-to-speech
    @State private var narrator = AudioNarrator()

    var body: some View {
        ZStack {
            // Orange background
            Color.orange
                .ignoresSafeArea()

            VStack(spacing: 100) {
                // Animated title text
                Text("Once upon a time...")
                    .font(.system(size: 48, weight: .heavy))
                    .foregroundStyle(.white)
                    .opacity(textOpacity)

                // Character heads with horizontal animation
                HStack(spacing: 80) {
                    Image("KonradHead")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)

                    Image("YaoHead")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)

                    Image("BlakeHead")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                }
                .offset(x: headsOffset)
            }
        }
        .onAppear {
            startAnimations()
            narrator.speak("Once upon a time there was a lot of students who were doing their best to get scholarships to Dub-Dub in San Jose")
        }
        .onDisappear {
            narrator.stop()
        }
    }

    /// Starts the intro animations when the view appears.
    ///
    /// This method initiates two animations:
    /// 1. A continuous pulsing effect on the title text
    /// 2. A subtle horizontal movement of the character heads
    private func startAnimations() {
        // Pulsing text animation
        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            textOpacity = 1.0
        }

        // Heads sliding in from the left
        withAnimation(.easeInOut(duration: 7.0)) {
            headsOffset = 0 // Slide from off-screen (-300) to center (0)
        }
    }
}

#Preview {
    IntroView()
}
