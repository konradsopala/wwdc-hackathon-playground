import SwiftUI

struct FirstDayView: View {
    @State private var showCharacters = false
    @State private var showSpeechBubbles = false
    @State private var narrator = AudioNarrator()

    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 30) {
                // Sky with venue
                ZStack {
                    Color(red: 0.60, green: 0.81, blue: 0.98)
                        .frame(height: 200)

                    Image("HackathonVenue")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }

                Spacer()

                // Characters with speech bubbles
                HStack(spacing: 40) {
                    VStack {
                        if showSpeechBubbles {
                            SpeechBubble(text: "Let's do it!", color: .red)
                                .transition(.scale.combined(with: .opacity))
                        }
                        Image("KonradMini")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 180)
                            .opacity(showCharacters ? 1 : 0)
                    }

                    VStack {
                        if showSpeechBubbles {
                            SpeechBubble(text: "Finally!", color: .orange)
                                .transition(.scale.combined(with: .opacity))
                        }
                        Image("BlakeMini")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 180)
                            .opacity(showCharacters ? 1 : 0)
                    }

                    VStack {
                        if showSpeechBubbles {
                            SpeechBubble(text: "Can't wait!", color: .red)
                                .transition(.scale.combined(with: .opacity))
                        }
                        Image("YaoMini")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 180)
                            .opacity(showCharacters ? 1 : 0)
                    }
                }

                // Core values
                Text("Core values: Learn • Create • Share")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .padding()

                Spacer()
            }
        }
        .onAppear {
            startAnimations()
            narrator.speak("Each year, around the same period of the year, the WWDC Scholarship contest is announced. This is the time when they gather around their MacBooks, building amazing software to showcase their skill and passion to become the WWDC Scholars")
        }
        .onDisappear {
            narrator.stop()
        }
    }

    private func startAnimations() {
        // Show characters first
        withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
            showCharacters = true
        }

        // Then show speech bubbles
        withAnimation(.spring(duration: 0.5).delay(2.0)) {
            showSpeechBubbles = true
        }
    }
}

struct SpeechBubble: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .heavy))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
            )
            .overlay(
                // Tail of speech bubble
                Triangle()
                    .fill(color)
                    .frame(width: 20, height: 15)
                    .rotationEffect(.degrees(180))
                    .offset(y: 20)
                , alignment: .bottom
            )
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

#Preview {
    FirstDayView()
}
