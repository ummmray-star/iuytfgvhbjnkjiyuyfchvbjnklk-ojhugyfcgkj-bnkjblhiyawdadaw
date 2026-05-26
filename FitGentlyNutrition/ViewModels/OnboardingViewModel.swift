import SwiftUI

@Observable
final class OnboardingViewModel {
    var currentStep: OnboardingStep = .welcome
    var userName: String = ""
    var selectedGoals: Set<String> = []
    var dietaryRestrictions: Set<String> = []

    let availableGoals = [
        "Eat more consistently",
        "Stay hydrated",
        "Get enough protein",
        "Improve energy",
        "Eat more fruits & vegetables",
    ]

    let availableRestrictions = [
        "Vegetarian",
        "Low sodium",
        "Dairy free",
        "Gluten free",
        "Diabetic friendly",
        "No restrictions",
    ]

    func advance() {
        guard let currentIndex = OnboardingStep.allCases.firstIndex(of: currentStep),
              currentIndex + 1 < OnboardingStep.allCases.count else { return }
        withAnimation(FGAnimations.gentle) {
            currentStep = OnboardingStep.allCases[currentIndex + 1]
        }
    }

    func skip() {
        advance()
    }

    var progress: Double {
        guard let index = OnboardingStep.allCases.firstIndex(of: currentStep) else { return 0 }
        return Double(index) / Double(OnboardingStep.allCases.count - 1)
    }

    func completeOnboarding(appState: AppState) {
        appState.userName = userName.isEmpty ? "Friend" : userName
        appState.hasCompletedOnboarding = true
    }
}
