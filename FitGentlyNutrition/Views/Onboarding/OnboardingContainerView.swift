import SwiftUI

struct OnboardingContainerView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(spacing: 0) {
            FGProgressBar(progress: viewModel.progress, color: FGColors.accent, height: 4)
                .padding(.horizontal, FGSpacing.screenPadding)
                .padding(.top, FGSpacing.md)

            Group {
                switch viewModel.currentStep {
                case .welcome:
                    WelcomeStepView(viewModel: viewModel)
                case .goals:
                    GoalsStepView(viewModel: viewModel)
                case .dietary:
                    DietaryStepView(viewModel: viewModel)
                case .tutorial:
                    InteractiveTutorialView(viewModel: viewModel)
                case .complete:
                    OnboardingCompleteView(viewModel: viewModel)
                }
            }
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
        }
        .background(FGColors.background)
    }
}
