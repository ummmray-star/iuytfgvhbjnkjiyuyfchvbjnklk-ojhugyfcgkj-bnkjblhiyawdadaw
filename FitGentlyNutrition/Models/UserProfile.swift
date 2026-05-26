import Foundation
import SwiftData

enum TextSizePreference: String, Codable, CaseIterable, Identifiable {
    case standard, large, extraLarge

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .standard: return "Standard"
        case .large: return "Large"
        case .extraLarge: return "Extra Large"
        }
    }

    var scaleFactor: CGFloat {
        switch self {
        case .standard: return 1.0
        case .large: return 1.15
        case .extraLarge: return 1.3
        }
    }
}

@Model
final class UserProfile {
    var id: UUID
    var displayName: String
    var dietaryRestrictions: [String]
    var dailyHydrationGoal: Int
    var textSizeRaw: String
    var hasCompletedOnboarding: Bool
    var caregiverEnabled: Bool
    var mealReminderEnabled: Bool
    var hydrationReminderEnabled: Bool
    var hydrationReminderIntervalMinutes: Int

    var textSizePreference: TextSizePreference {
        get { TextSizePreference(rawValue: textSizeRaw) ?? .large }
        set { textSizeRaw = newValue.rawValue }
    }

    init(displayName: String = "Friend") {
        self.id = UUID()
        self.displayName = displayName
        self.dietaryRestrictions = []
        self.dailyHydrationGoal = 8
        self.textSizeRaw = TextSizePreference.large.rawValue
        self.hasCompletedOnboarding = false
        self.caregiverEnabled = false
        self.mealReminderEnabled = true
        self.hydrationReminderEnabled = true
        self.hydrationReminderIntervalMinutes = 90
    }
}
