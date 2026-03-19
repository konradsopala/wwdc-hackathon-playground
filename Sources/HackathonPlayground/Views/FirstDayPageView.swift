import SwiftUI
import AVFoundation

/// First Day Page - Hackers arriving at the hackathon venue
public struct FirstDayPageView: View {
    @State private var carOffset: CGFloat = 400
    @State private var hackersOpacity: Double = 0
    @State private var hackersOffset: CGFloat = 0
    @State private var chatBubblesOpacity: Double = 0
    @State private var sunRaysOpacity: Double = 1.0
    @State private var speechSynthesizer = AVSpeechSynthesizer()

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Sky
                VStack(spacing: 0) {
                    Color(red: 0.60, green: 0.81, blue: 0.98)
                        .frame(height: geometry.size.height * 0.3)

                    // Green fields and pathway
                    HStack(spacing: 0) {
                        Color.green.opacity(0.7)
                            .frame(width: geometry.size.width * 0.2)
                        Color(red: 0.76, green: 0.70, blue: 0.50)
                        Color.green.opacity(0.7)
                            .frame(width: geometry.size.width * 0.2)
                    }
                }
                .ignoresSafeArea()

                // Hackathon Venue
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.8))
                    .frame(width: 200, height: 120)
                    .overlay(
                        Text("HACKATHON")
                            .font(.custom("Avenir-Heavy", size: 16))
                            .foregroundStyle(.white)
                    )
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.15)

                // Sun with rays
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 70, height: 70)

                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(Color.yellow.opacity(0.6))
                            .frame(width: 30, height: 8)
                            .offset(x: -50)
                            .rotationEffect(.degrees(Double(index) * 20 - 40))
                            .opacity(sunRaysOpacity)
                    }
                }
                .position(x: geometry.size.width - 80, y: 60)

                // Trees
                TreeView()
                    .position(x: 60, y: geometry.size.height * 0.45)
                TreeView()
                    .position(x: geometry.size.width - 60, y: geometry.size.height * 0.45)

                // Hackers
                HStack(spacing: 40) {
                    HackerMiniView(color: .blue, name: "K")
                    HackerMiniView(color: .purple, name: "B")
                    HackerMiniView(color: .green, name: "Y")
                }
                .opacity(hackersOpacity)
                .offset(y: hackersOffset)
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.75)

                // Chat bubbles
                HStack(spacing: 20) {
                    ChatBubbleView(text: "Let's do it!", color: .red)
                    ChatBubbleView(text: "Finally!", color: .orange)
                    ChatBubbleView(text: "Can't wait!", color: .red)
                }
                .opacity(chatBubblesOpacity)
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.35)

                // Car
                CarView()
                    .offset(x: carOffset)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.85)
            }
        }
        .onAppear {
            startAnimations()
            tellStory()
        }
    }

    private func startAnimations() {
        sunShineAnimation()

        // Drive car to venue
        withAnimation(.easeInOut(duration: 7.0)) {
            carOffset = 0
        }

        // Hackers get out of car
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            withAnimation(.easeIn(duration: 2.0)) {
                hackersOpacity = 1.0
            }
        }

        // Drive car away and hackers walk to venue
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            withAnimation(.easeInOut(duration: 5.0)) {
                carOffset = -500
            }

            withAnimation(.easeInOut(duration: 3.0)) {
                hackersOffset = -200
            }
        }

        // Show chat bubbles
        DispatchQueue.main.asyncAfter(deadline: .now() + 14.0) {
            withAnimation(.easeIn(duration: 1.0)) {
                chatBubblesOpacity = 1.0
            }
        }
    }

    private func sunShineAnimation() {
        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
            sunRaysOpacity = 0.3
        }
    }

    private func tellStory() {
        let storyText = AVSpeechUtterance(string: "Each year, around the same period of the year, the WWDC Scholarship contest is announced. This is the time when they gather around their MacBooks, building amazing software to showcase their skill and passion to become the WWDC Scholars")
        storyText.rate = AVSpeechUtteranceDefaultSpeechRate
        storyText.voice = AVSpeechSynthesisVoice(language: "en-US")

        if !speechSynthesizer.isSpeaking {
            speechSynthesizer.speak(storyText)
        }
    }
}

struct TreeView: View {
    var body: some View {
        VStack(spacing: -10) {
            Triangle()
                .fill(Color.green.opacity(0.8))
                .frame(width: 60, height: 70)
            Rectangle()
                .fill(Color.brown)
                .frame(width: 15, height: 30)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct HackerMiniView: View {
    let color: Color
    let name: String

    var body: some View {
        VStack(spacing: 5) {
            Circle()
                .fill(color)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                )
            RoundedRectangle(cornerRadius: 5)
                .fill(color.opacity(0.8))
                .frame(width: 30, height: 50)
        }
    }
}

struct ChatBubbleView: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.custom("Avenir-Heavy", size: 12))
            .foregroundStyle(.white)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
            )
    }
}

struct CarView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.red)
                .frame(width: 100, height: 40)

            RoundedRectangle(cornerRadius: 5)
                .fill(Color.blue.opacity(0.5))
                .frame(width: 50, height: 25)
                .offset(y: -5)

            HStack(spacing: 50) {
                Circle()
                    .fill(Color.black)
                    .frame(width: 20, height: 20)
                Circle()
                    .fill(Color.black)
                    .frame(width: 20, height: 20)
            }
            .offset(y: 20)
        }
    }
}

#Preview {
    FirstDayPageView()
}
