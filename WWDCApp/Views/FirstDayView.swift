import SwiftUI

/// The first day page showing the characters arriving at the hackathon venue.
///
/// This view depicts:
/// - A sky background with the hackathon venue
/// - Three characters (Konrad, Blake, Yao) appearing with fade-in animation
/// - Speech bubbles expressing their excitement
/// - The core values of hackathons: Learn • Create • Share
/// - Audio narration about the WWDC Scholarship contest
struct FirstDayView: View {
    /// Controls the visibility of character images
    @State private var showCharacters = false

    /// Controls the visibility of speech bubbles
    @State private var showSpeechBubbles = false

    /// Audio narrator instance for text-to-speech
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

    /// Starts the sequential animations for character arrival.
    ///
    /// Animates in two stages:
    /// 1. Characters fade in after a short delay
    /// 2. Speech bubbles pop in with a spring animation
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

/// A custom speech bubble view component with a triangular tail.
///
/// This reusable component creates a chat-bubble style UI element
/// that can be customized with different text and colors.
///
/// - Parameters:
///   - text: The message to display in the bubble
///   - color: The background color of the bubble
struct SpeechBubble: View {
    /// The text content displayed in the speech bubble
    let text: String

    /// The background color of the speech bubble
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

/// A custom triangle shape used as the tail of speech bubbles.
///
/// Creates an isosceles triangle pointing downward, which is then rotated
/// to create the classic speech bubble tail effect.
struct Triangle: Shape {
    /// Creates the triangular path within the given rectangle.
    ///
    /// - Parameter rect: The rectangle in which to draw the triangle
    /// - Returns: A path representing the triangle shape
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
