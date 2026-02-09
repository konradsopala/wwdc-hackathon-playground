import SwiftUI

struct FinalDayView: View {
    @State private var timeRemaining = TimeComponents(days: 0, hours: 0, minutes: 0, seconds: 0)
    @State private var showSweat = false
    @State private var sweatOffset: CGFloat = 0
    @State private var narrator = AudioNarrator()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // Target date: April 20, 2026 (update for current year)
    let targetDate: Date = {
        var components = DateComponents()
        components.year = 2026
        components.month = 4
        components.day = 20
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()

    var body: some View {
        ZStack {
            // Background
            Color(red: 0.73, green: 0.44, blue: 0.44)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                // Title
                Text("Hackathon Winners Announcement")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Countdown timer
                VStack(spacing: 16) {
                    Text("Time Until Results")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.8))

                    HStack(spacing: 20) {
                        TimeUnitView(value: timeRemaining.days, unit: "Days")
                        TimeUnitView(value: timeRemaining.hours, unit: "Hours")
                        TimeUnitView(value: timeRemaining.minutes, unit: "Min")
                        TimeUnitView(value: timeRemaining.seconds, unit: "Sec")
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.black.opacity(0.3))
                )

                // Anxious characters with sweat drops
                HStack(spacing: 40) {
                    CharacterWithSweat(
                        image: "Konrad",
                        showSweat: showSweat,
                        sweatOffset: sweatOffset
                    )

                    CharacterWithSweat(
                        image: "Blake",
                        showSweat: showSweat,
                        sweatOffset: sweatOffset
                    )

                    CharacterWithSweat(
                        image: "Yao",
                        showSweat: showSweat,
                        sweatOffset: sweatOffset
                    )
                }

                Spacer()
            }
            .padding(.top, 50)
        }
        .onAppear {
            updateTimeRemaining()
            startAnimations()
            narrator.speak("Finally, after co-operating and helping each other for one week, they had to submit their robust playgrounds. Feeling anxious and nervous about the results, they started looking into uncertain future")
        }
        .onDisappear {
            narrator.stop()
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }

    private func updateTimeRemaining() {
        let now = Date()
        let components = Calendar.current.dateComponents(
            [.day, .hour, .minute, .second],
            from: now,
            to: targetDate
        )

        timeRemaining = TimeComponents(
            days: max(components.day ?? 0, 0),
            hours: max(components.hour ?? 0, 0),
            minutes: max(components.minute ?? 0, 0),
            seconds: max(components.second ?? 0, 0)
        )
    }

    private func startAnimations() {
        // Show sweat drops with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeIn(duration: 0.5)) {
                showSweat = true
            }

            // Animate sweat falling
            withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: false)) {
                sweatOffset = 30
            }
        }
    }
}

struct TimeComponents {
    var days: Int
    var hours: Int
    var minutes: Int
    var seconds: Int
}

struct TimeUnitView: View {
    let value: Int
    let unit: String

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.49, green: 0.83, blue: 0.13))

            Text(unit)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(width: 70)
    }
}

struct CharacterWithSweat: View {
    let image: String
    let showSweat: Bool
    let sweatOffset: CGFloat

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 160)

            if showSweat {
                Image("Sweat")
                    .resizable()
                    .frame(width: 15, height: 25)
                    .offset(x: 20, y: -50 + sweatOffset)
                    .opacity(showSweat ? 1 : 0)
            }
        }
    }
}

#Preview {
    FinalDayView()
}
