import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState
    @State private var showingAddMeal = false

    var body: some View {
        @Bindable var state = appState

        ZStack(alignment: .bottom) {
            TabView(selection: $state.selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(AppTab.home)

                NavigationStack {
                    MealsView()
                }
                .tabItem { Label("Meals", systemImage: "fork.knife") }
                .tag(AppTab.meals)

                // Empty center slot — FAB overlays this gap visually
                Color.clear
                    .tabItem { Label("", systemImage: "plus.circle.fill") }
                    .tag(AppTab.meals) // intentionally same tag so tapping does nothing disruptive

                NavigationStack {
                    ProgressTabView()
                }
                .tabItem { Label("Progress", systemImage: "chart.line.uptrend.xyaxis") }
                .tag(AppTab.progress)

                NavigationStack {
                    MoreView()
                }
                .tabItem { Label("More", systemImage: "ellipsis") }
                .tag(AppTab.more)
            }
            .tint(FGColors.accent)

            // Floating Add button — visually centered over the tab bar
            Button {
                showingAddMeal = true
            } label: {
                ZStack {
                    Circle()
                        .fill(FGColors.accent)
                        .frame(width: 58, height: 58)
                        .shadow(color: FGColors.accent.opacity(0.5), radius: 10, x: 0, y: 4)
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(FGColors.textOnAccent)
                }
            }
            .accessibilityLabel("Log a meal")
            .padding(.bottom, 16)
        }
        .sheet(isPresented: $showingAddMeal) {
            LogMealSheet()
        }
    }
}
