import UserNotifications

final class NotificationService {
    static let shared = NotificationService()

    func requestPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }

    func scheduleMealReminder(mealType: MealType, hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Time for \(mealType.displayName)"
        content.body = mealReminderMessage(for: mealType)
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: "meal-\(mealType.rawValue)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func scheduleHydrationReminder(intervalMinutes: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Stay Hydrated"
        content.body = "Time for a small glass of water. It helps with energy and balance."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(intervalMinutes * 60),
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: "hydration",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    func cancelAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func mealReminderMessage(for mealType: MealType) -> String {
        switch mealType {
        case .breakfast: return "A good breakfast sets the tone for the day."
        case .lunch: return "Lunchtime! Even a light meal keeps energy steady."
        case .dinner: return "Time for dinner. A warm meal can help you wind down."
        case .snack: return "A small healthy snack can keep you feeling good."
        }
    }
}
