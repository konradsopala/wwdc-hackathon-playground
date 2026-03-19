import SwiftUI
import AVFoundation

/// Final Day Page - Waiting for hackathon results announcement
public struct FinalDayPageView: View {
    @State private var timeRemaining = TimeInterval(86400) // 24 hours
    @State private var sweatDropOffset: CGFloat = 0
    @State private var sweatOpacity: Double = 0
    @State private var speechSynthesizer = AVSpeechSynthesizer()
    @State private var timer: Timer?

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color(red: 0.73, green: 0.44, blue: 0.44)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    // Title
                    Text("Hackathon winners announcement")
                        .font(.custom("Avenir-Heavy", size: 28))
                        .foregroundStyle(.white)
                        .padding(.top, 60)

                    // Timer display
                    TimerDisplayView(timeRemaining: timeRemaining)

                    Spacer()

                    // Nervous hackers
                    HStack(spacing: 20) {
                        NervousHackerView(
                            name: "K",
                            color: .blue,
                            sweatOffset: sweatDropOffset,
                            sweatOpacity: sweatOpacity
                        )

                        NervousHackerView(
                            name: "B",
                            color: .purple,
                            sweatOffset: sweatDropOffset,
                            sweatOpacity: sweatOpacity,
                            doubleSweat: true
                        )

                        NervousHackerView(
                            name: "Y",
                            color: .green,
                            sweatOffset: sweatDropOffset,
                            sweatOpacity: sweatOpacity
                        )
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            startAnimations()
            startTimer()
            tellStory()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }

    private func startAnimations() {
        // Show sweat with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeIn(duration: 2.0)) {
                sweatOpacity = 1.0
            }
        }

        // Animate sweat drops falling
        withAnimation(.easeIn(duration: 11.0)) {
            sweatDropOffset = 30
        }
    }

    private func tellStory() {
        let storyText = AVSpeechUtterance(string: "Finally, after co-operating and helping each other for one week, they had to submit their robust playgrounds. Feeling anxious and nervous about the results, they started looking into uncertain future")
        storyText.rate = AVSpeechUtteranceDefaultSpeechRate
        storyText.voice = AVSpeechSynthesisVoice(language: "en-US")

        if !speechSynthesizer.isSpeaking {
            speechSynthesizer.speak(storyText)
        }
    }
}

struct TimerDisplayView: View {
    let timeRemaining: TimeInterval

    private var days: Int {
        Int(timeRemaining) / 86400
    }

    private var hours: Int {
        (Int(timeRemaining) % 86400) / 3600
    }

    private var minutes: Int {
        (Int(timeRemaining) % 3600) / 60
    }

    private var seconds: Int {
        Int(timeRemaining) % 60
    }

    var body: some View {
        HStack(spacing: 0) {
            // Timer background
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.8))
                .frame(height: 80)
                .overlay(
                    Text("\(days) Days \(hours) Hours \(minutes) Min \(seconds) Sec")
                        .font(.custom("Avenir-Heavy", size: 24))
                        .foregroundStyle(Color(red: 0.49, green: 0.83, blue: 0.13))
                )
        }
        .padding(.horizontal, 40)
    }
}

struct NervousHackerView: View {
    let name: String
    let color: Color
    let sweatOffset: CGFloat
    let sweatOpacity: Double
    var doubleSweat: Bool = false

    var body: some View {
        ZStack {
            // Hacker body
            VStack(spacing: 5) {
                Circle()
                    .fill(color)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text(name)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(.white)
                    )

                RoundedRectangle(cornerRadius: 10)
                    .fill(color.opacity(0.8))
                    .frame(width: 70, height: 150)
            }

            // Sweat drops
            VStack {
                HStack(spacing: doubleSweat ? 10 : 0) {
                    SweatDropView()
                        .offset(y: sweatOffset)
                        .opacity(sweatOpacity)

                    if doubleSweat {
                        SweatDropView()
                            .offset(y: sweatOffset)
                            .opacity(sweatOpacity)
                    }
                }
                Spacer()
            }
            .offset(x: 35, y: -25)
        }
    }
}

struct SweatDropView: View {
    var body: some View {
        Ellipse()
            .fill(Color.blue.opacity(0.7))
            .frame(width: 10, height: 18)
    }
}

#Preview {
    FinalDayPageView()
}
