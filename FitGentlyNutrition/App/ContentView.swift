import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var state = appState

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

            NavigationStack {
                ProgressTabView()
            }
            .tabItem { Label("Progress", systemImage: "chart.line.uptrend.xyaxis") }
            .tag(AppTab.progress)

            NavigationStack {
                PlansView()
            }
            .tabItem { Label("Plans", systemImage: "list.clipboard.fill") }
            .tag(AppTab.plans)

            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gearshape.fill") }
            .tag(AppTab.settings)
        }
        .tint(FGColors.accent)
    }
}
