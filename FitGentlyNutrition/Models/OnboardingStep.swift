import Foundation

enum OnboardingStep: Int, CaseIterable, Identifiable {
    case welcome
    case goals
    case dietary
    case tutorial
    case complete

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .welcome: return "Welcome"
        case .goals: return "Your Goals"
        case .dietary: return "Dietary Needs"
        case .tutorial: return "Quick Tour"
        case .complete: return "All Set!"
        }
    }

    var isSkippable: Bool {
        switch self {
        case .welcome, .complete: return false
        case .goals, .dietary, .tutorial: return true
        }
    }
}
