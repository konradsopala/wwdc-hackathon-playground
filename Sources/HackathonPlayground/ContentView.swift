import SwiftUI

/// Main content view with tab navigation through hackathon story pages
public struct ContentView: View {
    @State private var selectedPage = 0

    public init() {}

    public var body: some View {
        TabView(selection: $selectedPage) {
            IntroPageView()
                .tag(0)

            FirstDayPageView()
                .tag(1)

            SecondDayPageView()
                .tag(2)

            FinalDayPageView()
                .tag(3)

            LastPageView()
                .tag(4)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
