import SwiftUI

@Observable
final class AppState {
    var hasCompletedOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasCompletedOnboarding, forKey: "hasCompletedOnboarding") }
    }
    var selectedTab: AppTab = .home
    var userName: String = "Friend"

    init() {
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
}

enum AppTab: Int, CaseIterable, Identifiable {
    case home, meals, progress, more

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .meals: return "Meals"
        case .progress: return "Progress"
        case .more: return "More"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .meals: return "fork.knife"
        case .progress: return "chart.line.uptrend.xyaxis"
        case .more: return "ellipsis"
        }
    }
}
