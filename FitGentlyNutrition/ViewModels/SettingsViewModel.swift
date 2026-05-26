import SwiftUI

@Observable
final class SettingsViewModel {
    var mealRemindersEnabled = true
    var hydrationRemindersEnabled = true
    var textSize: TextSizePreference = .large
    var hydrationGoal: Int = 8
    var caregiverEnabled = false

    func resetOnboarding(appState: AppState) {
        appState.hasCompletedOnboarding = false
    }

    func updateReminders() {
        let service = NotificationService.shared
        service.cancelAll()

        if mealRemindersEnabled {
            service.scheduleMealReminder(mealType: .breakfast, hour: 8, minute: 0)
            service.scheduleMealReminder(mealType: .lunch, hour: 12, minute: 30)
            service.scheduleMealReminder(mealType: .dinner, hour: 18, minute: 0)
        }

        if hydrationRemindersEnabled {
            service.scheduleHydrationReminder(intervalMinutes: 90)
        }
    }
}
