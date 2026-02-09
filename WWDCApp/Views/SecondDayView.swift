import SwiftUI

struct SecondDayView: View {
    @State private var animateBirds = false
    @State private var showCode = [false, false, false]
    @State private var codeScale = [1.0, 1.0, 1.0]
    @State private var isDayTime = true
    @State private var narrator = AudioNarrator()

    var body: some View {
        ZStack {
            // Background color
            Color(red: 0.00, green: 0.67, blue: 0.54)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                // Window showing day/night cycle
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isDayTime ? Color(red: 0.60, green: 0.81, blue: 0.98) : Color.black.opacity(0.8))
                        .frame(height: 150)

                    if isDayTime {
                        Image("Sun")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .offset(x: 120, y: -20)
                    } else {
                        Image("AppleMoon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .offset(x: -120, y: -20)
                    }

                    if isDayTime {
                        // Flying birds
                        Image("DarkBird")
                            .resizable()
                            .frame(width: 50, height: 20)
                            .offset(x: animateBirds ? 40 : -40, y: -30)
                    }
                }
                .padding()

                // Coding scene
                HStack(spacing: 40) {
                    CodingHackerView(
                        name: "Konrad",
                        image: "KonradBack",
                        code: "add(2,2) = 4",
                        showCode: showCode[0],
                        scale: codeScale[0]
                    )

                    CodingHackerView(
                        name: "Blake",
                        image: "BlakeBack",
                        code: "confetti()",
                        showCode: showCode[1],
                        scale: codeScale[1]
                    )

                    CodingHackerView(
                        name: "Yao",
                        image: "YaoBack",
                        code: "drawZ()",
                        showCode: showCode[2],
                        scale: codeScale[2]
                    )
                }

                Spacer()

                Text("Coding through day and night...")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
        }
        .onAppear {
            startAnimations()
            narrator.speak("Once they start building their software ideas, they go a long way till they create what they initially desired. In the meantime there may come bugs, necessity to learn new APIs and SDKs and so on. Truth to be told, they do not have to worry about any of those things as they belong to the iOS community")
        }
        .onDisappear {
            narrator.stop()
        }
    }

    private func startAnimations() {
        // Bird animation
        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            animateBirds = true
        }

        // Code animations - staggered
        for i in 0..<3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 2) {
                withAnimation(.easeIn(duration: 0.5)) {
                    showCode[i] = true
                }
                withAnimation(.spring(duration: 1.0).delay(0.5)) {
                    codeScale[i] = 1.2
                }
            }
        }

        // Day/night transition
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            withAnimation(.easeInOut(duration: 2.0)) {
                isDayTime = false
            }
        }
    }
}

struct CodingHackerView: View {
    let name: String
    let image: String
    let code: String
    let showCode: Bool
    let scale: Double

    var body: some View {
        VStack(spacing: 12) {
            if showCode {
                Text(code)
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.black.opacity(0.6))
                    )
                    .scaleEffect(scale)
                    .transition(.scale.combined(with: .opacity))
            }

            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 130)
        }
    }
}

#Preview {
    SecondDayView()
}
