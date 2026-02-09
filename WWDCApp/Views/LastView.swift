import SwiftUI

struct LastView: View {
    @State private var textOffset: CGFloat = -400
    @State private var rotationDegrees = 0.0
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
