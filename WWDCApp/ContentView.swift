import SwiftUI

struct ContentView: View {
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            // Page-based story book navigation
            TabView(selection: $currentPage) {
                IntroView()
                    .tag(0)

                FirstDayView()
                    .tag(1)

                SecondDayView()
                    .tag(2)

                FinalDayView()
                    .tag(3)

                LastView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))

            // Page indicator overlay
            VStack {
                Spacer()

                HStack(spacing: 20) {
                    if currentPage > 0 {
                        Button(action: { withAnimation { currentPage -= 1 } }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.white.opacity(0.7))
                                .shadow(radius: 5)
                        }
                    }

                    Spacer()

                    if currentPage < 4 {
                        Button(action: { withAnimation { currentPage += 1 } }) {
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.white.opacity(0.7))
                                .shadow(radius: 5)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 60)
            }
        }
    }
}

#Preview {
    ContentView()
}
