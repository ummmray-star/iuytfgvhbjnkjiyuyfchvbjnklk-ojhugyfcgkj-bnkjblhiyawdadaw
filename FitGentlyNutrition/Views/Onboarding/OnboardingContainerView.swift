import SwiftUI

struct OnboardingContainerView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(FGColors.divider)
                        .frame(height: 6)
                        .clipShape(Capsule())

                    Rectangle()
                        .fill(FGColors.accent)
                        .frame(width: geo.size.width * viewModel.progress, height: 6)
                        .clipShape(Capsule())
                        .animation(FGAnimations.gentle, value: viewModel.progress)
                }
            }
            .frame(height: 6)
            .padding(.horizontal, FGSpacing.screenPadding)
            .padding(.top, FGSpacing.lg)
            .padding(.bottom, FGSpacing.md)

            // Step content
            ZStack {
                switch viewModel.currentStep {
                case .welcome:
                    WelcomeStepView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                case .goals:
                    GoalsStepView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                case .dietary:
                    DietaryStepView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                case .tutorial:
                    InteractiveTutorialView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                case .complete:
                    OnboardingCompleteView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }
            }
            .animation(FGAnimations.gentle, value: viewModel.currentStep)
        }
        .background(FGColors.background)
    }
}
