import SwiftUI
import AVFoundation

/// Second Day Page - Hackers coding at their workstations
public struct SecondDayPageView: View {
    @State private var isNightMode = false
    @State private var birdOffset: CGFloat = 0
    @State private var sunRaysOpacity: Double = 1.0
    @State private var codeOpacity: [Double] = [0, 0, 0]
    @State private var confettiOpacity: Double = 0
    @State private var circleOffset: CGFloat = 0
    @State private var ufoOffset: CGFloat = -100
    @State private var speechSynthesizer = AVSpeechSynthesizer()

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color(red: 0.00, green: 0.67, blue: 0.54)
                    .ignoresSafeArea()

                // Window
                VStack {
                    WindowView(isNightMode: isNightMode, sunRaysOpacity: sunRaysOpacity, birdOffset: birdOffset, ufoOffset: ufoOffset)
                        .frame(height: 170)
                        .padding(.horizontal, 20)
                        .padding(.top, 40)

                    Spacer()
                }

                // Desk
                Rectangle()
                    .fill(Color(red: 0.25, green: 0.25, blue: 0.25))
                    .frame(height: 50)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.52)

                // Workstations
                HStack(spacing: 30) {
                    WorkstationView(
                        hackerName: "K",
                        hackerColor: .blue,
                        pillowColor: .red,
                        code: "add(2,2)",
                        codeResult: "4",
                        codeOpacity: codeOpacity[0]
                    )

                    WorkstationView(
                        hackerName: "B",
                        hackerColor: .purple,
                        pillowColor: .blue,
                        code: "confetti()",
                        codeResult: nil,
                        codeOpacity: codeOpacity[1],
                        showConfetti: confettiOpacity > 0
                    )

                    WorkstationView(
                        hackerName: "Y",
                        hackerColor: .green,
                        pillowColor: .yellow,
                        code: "drawZ()",
                        codeResult: nil,
                        codeOpacity: codeOpacity[2],
                        circleOffset: circleOffset
                    )
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.72)
            }
        }
        .onAppear {
            startAnimations()
            tellStory()
        }
    }

    private func startAnimations() {
        // Bird flying animation
        withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
            birdOffset = 15
        }

        // Sun shine animation
        withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
            sunRaysOpacity = 0.3
        }

        // UFO flying
        withAnimation(.easeInOut(duration: 7.0)) {
            ufoOffset = 350
        }

        // Code animations
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            withAnimation(.easeIn(duration: 1.5)) {
                codeOpacity[0] = 1.0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
            withAnimation(.easeIn(duration: 1.5)) {
                codeOpacity[1] = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeIn(duration: 2.0)) {
                    confettiOpacity = 1.0
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 17.0) {
            withAnimation(.easeIn(duration: 1.5)) {
                codeOpacity[2] = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    circleOffset = 50
                }
            }
        }

        // Switch to night mode
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
            withAnimation(.easeInOut(duration: 3.0)) {
                isNightMode = true
            }
        }
    }

    private func tellStory() {
        let storyText = AVSpeechUtterance(string: "Once they start building their software ideas, they go a long way till they create what they initially desired. In the meantime there may come bugs, necessity to learn new APIs and SDKs and so on. Truth to be told, they do not have to worry about any of those things as they belong to the iOS community.")
        storyText.rate = AVSpeechUtteranceDefaultSpeechRate
        storyText.voice = AVSpeechSynthesisVoice(language: "en-US")

        if !speechSynthesizer.isSpeaking {
            speechSynthesizer.speak(storyText)
        }
    }
}

struct WindowView: View {
    let isNightMode: Bool
    let sunRaysOpacity: Double
    let birdOffset: CGFloat
    let ufoOffset: CGFloat

    var body: some View {
        ZStack {
            // Window frame
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.brown, lineWidth: 10)

            // Sky background
            Rectangle()
                .fill(isNightMode ?
                    Color(red: 0.1, green: 0.1, blue: 0.3) :
                    Color(red: 0.53, green: 0.81, blue: 0.92))

            if isNightMode {
                // Moon and stars
                Circle()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 40, height: 40)
                    .position(x: 60, y: 50)

                ForEach(0..<4) { index in
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .position(x: CGFloat(100 + index * 40), y: CGFloat(40 + (index % 2) * 30))
                }
            } else {
                // Sun with rays
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 50, height: 50)

                    ForEach(0..<3) { index in
                        Rectangle()
                            .fill(Color.yellow.opacity(0.6))
                            .frame(width: 25, height: 6)
                            .offset(x: -40)
                            .rotationEffect(.degrees(Double(index) * 25 - 25))
                            .opacity(sunRaysOpacity)
                    }
                }
                .position(x: 300, y: 50)

                // Birds
                ForEach(0..<3) { index in
                    Image(systemName: "bird.fill")
                        .foregroundStyle(.gray)
                        .position(x: CGFloat(80 + index * 120), y: CGFloat(60 + (index % 2) * 30))
                        .offset(x: birdOffset * (index % 2 == 0 ? 1 : -1))
                }

                // UFO
                Image(systemName: "airplane")
                    .rotationEffect(.degrees(180))
                    .foregroundStyle(.gray)
                    .position(x: ufoOffset, y: 50)
            }

            // Grass at bottom of window
            Rectangle()
                .fill(Color.green)
                .frame(height: 20)
                .position(x: 180, y: 155)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct WorkstationView: View {
    let hackerName: String
    let hackerColor: Color
    let pillowColor: Color
    let code: String
    let codeResult: String?
    var codeOpacity: Double = 0
    var showConfetti: Bool = false
    var circleOffset: CGFloat = 0

    var body: some View {
        VStack(spacing: 5) {
            // iMac
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 80)

                VStack {
                    Text(code)
                        .font(.custom("Avenir-Heavy", size: 10))
                        .foregroundStyle(.black)
                        .opacity(codeOpacity)

                    if let result = codeResult {
                        Text(result)
                            .font(.custom("Avenir-Heavy", size: 16))
                            .foregroundStyle(.blue)
                            .opacity(codeOpacity)
                    }

                    if showConfetti {
                        HStack(spacing: 5) {
                            ForEach(0..<4) { index in
                                Circle()
                                    .fill([Color.red, .blue, .green, .yellow][index])
                                    .frame(width: 8, height: 8)
                            }
                        }
                    }

                    if circleOffset != 0 {
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 15, height: 15)
                            .offset(x: circleOffset)
                    }
                }
            }

            // Keyboard
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.white)
                .frame(width: 80, height: 15)

            // Pillow
            RoundedRectangle(cornerRadius: 10)
                .fill(pillowColor.opacity(0.6))
                .frame(width: 80, height: 60)

            // Hacker
            VStack(spacing: 2) {
                Circle()
                    .fill(hackerColor)
                    .frame(width: 35, height: 35)
                    .overlay(
                        Text(hackerName)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                    )
                RoundedRectangle(cornerRadius: 5)
                    .fill(hackerColor.opacity(0.8))
                    .frame(width: 50, height: 60)
            }
        }
    }
}

#Preview {
    SecondDayPageView()
}
