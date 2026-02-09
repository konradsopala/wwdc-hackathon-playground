import SwiftUI
import Combine

/// The final day page showing anxious characters waiting for hackathon results.
///
/// This view features:
/// - A countdown timer showing days, hours, minutes, and seconds until results
/// - Three anxious characters with animated sweat drops
/// - A dramatic brown/red background conveying tension
/// - Audio narration about the anticipation and nervousness
/// - Real-time timer updates every second
struct FinalDayView: View {
    /// The remaining time until the target announcement date
    @State private var timeRemaining = TimeComponents(days: 0, hours: 0, minutes: 0, seconds: 0)

    /// Controls the visibility of sweat drop animations
    @State private var showSweat = false

    /// Vertical offset for the falling sweat animation
    @State private var sweatOffset: CGFloat = 0

    /// Audio narrator instance for text-to-speech
    @State private var narrator = AudioNarrator()

    /// Cancellable subscription for the timer
    /// Stored to ensure the timer is properly cancelled when the view disappears,
    /// preventing memory leaks and unnecessary background processing
    @State private var timerCancellable: Cancellable?

    /// Timer publisher that fires every second to update the countdown
    /// Note: This timer is manually connected in onAppear and cancelled in onDisappear
    /// to prevent it from continuing to fire after the view is no longer visible
    let timer = Timer.publish(every: 1, on: .main, in: .common)

    /// Target date for the results announcement
    /// Update the year, month, and day as needed for your use case
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

            // Manually connect the timer and store the cancellable for cleanup
            timerCancellable = timer.connect()
        }
        .onDisappear {
            narrator.stop()

            // Cancel the timer to prevent it from continuing to fire
            timerCancellable?.cancel()
            timerCancellable = nil
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }

    /// Updates the countdown timer by calculating the time difference between now and the target date.
    ///
    /// Called every second by the timer publisher and once on view appearance.
    /// Ensures all values are non-negative (won't show negative time if date has passed).
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

    /// Starts the anxiety animations after a brief delay.
    ///
    /// Initiates two animations:
    /// 1. Fades in the sweat drops after 1 second
    /// 2. Continuously animates the sweat falling downward
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

/// A data structure representing time components for the countdown display.
///
/// Breaks down time into easily displayable units.
struct TimeComponents {
    /// Number of full days remaining
    var days: Int

    /// Number of hours remaining (0-23)
    var hours: Int

    /// Number of minutes remaining (0-59)
    var minutes: Int

    /// Number of seconds remaining (0-59)
    var seconds: Int
}

/// A view component displaying a single unit of time in the countdown.
///
/// Shows a numeric value with its unit label in a vertically stacked layout.
/// Used to display days, hours, minutes, or seconds.
struct TimeUnitView: View {
    /// The numeric value to display
    let value: Int

    /// The time unit label (e.g., "Days", "Hours")
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

/// A view component showing an anxious character with an animated sweat drop.
///
/// Displays a character image with a sweat drop positioned above their head
/// that can animate downward to convey anxiety or nervousness.
struct CharacterWithSweat: View {
    /// The asset name for the character's image
    let image: String

    /// Whether to show the sweat drop
    let showSweat: Bool

    /// Vertical offset for the sweat drop animation
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
