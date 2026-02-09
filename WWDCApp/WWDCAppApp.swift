import SwiftUI

/// The main app structure for the Hackathon Story iOS application.
///
/// This is the entry point of the app, which presents the story through
/// a page-based navigation interface. The app tells the story of students
/// working on their WWDC Scholarship submissions through five animated pages.
///
/// ## Requirements
/// - iOS 17.0+
/// - Images from the original playground in Assets.xcassets
/// - AVFoundation for audio narration
@main
struct WWDCAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
