import SwiftUI

struct IntroView: View {
    @State private var textOpacity: Double = 0
    @State private var headsOffset: CGFloat = 0
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

    private func startAnimations() {
        // Pulsing text animation
        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            textOpacity = 1.0
        }

        // Heads moving together
        withAnimation(.easeInOut(duration: 7.0)) {
            headsOffset = 0 // They start spread out and come together
        }
    }
}

#Preview {
    IntroView()
}
