import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var state = appState

        TabView(selection: $state.selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                NavigationStack {
                    HomeView()
                }
            }

            Tab("Meals", systemImage: "fork.knife", value: .meals) {
                NavigationStack {
                    MealsView()
                }
            }

            Tab("Progress", systemImage: "chart.line.uptrend.xyaxis", value: .progress) {
                NavigationStack {
                    ProgressTabView()
                }
            }

            Tab("Plans", systemImage: "list.clipboard.fill", value: .plans) {
                NavigationStack {
                    PlansView()
                }
            }

            Tab("Settings", systemImage: "gearshape.fill", value: .settings) {
                NavigationStack {
                    SettingsView()
                }
            }
        }
        .tint(FGColors.accent)
    }
}
