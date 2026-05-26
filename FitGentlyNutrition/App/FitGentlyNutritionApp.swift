import SwiftUI
import SwiftData

@main
struct FitGentlyNutritionApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            Group {
                if appState.hasCompletedOnboarding {
                    ContentView()
                } else {
                    OnboardingContainerView()
                }
            }
            .environment(appState)
        }
        .modelContainer(for: [
            MealEntry.self,
            FoodItem.self,
            HydrationEntry.self,
            DailySnapshot.self,
            AIInsight.self,
            UserProfile.self,
            CaregiverLink.self,
        ])
    }
}
