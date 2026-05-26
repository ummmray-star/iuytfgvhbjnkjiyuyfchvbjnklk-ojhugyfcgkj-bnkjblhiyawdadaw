import SwiftUI

struct OnboardingCompleteView: View {
    @Environment(AppState.self) private var appState
    @Bindable var viewModel: OnboardingViewModel
    @State private var showConfetti = false

    var body: some View {
        VStack(spacing: FGSpacing.xl) {
            Spacer()

            VStack(spacing: FGSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(FGColors.accent.opacity(0.15))
                        .frame(width: 120, height: 120)
                        .scaleEffect(showConfetti ? 1.0 : 0.5)
                        .animation(FGAnimations.bounce, value: showConfetti)

                    Image(systemName: "sparkles")
                        .font(.system(size: 52, weight: .light))
                        .foregroundStyle(FGColors.accent)
                        .scaleEffect(showConfetti ? 1.0 : 0.3)
                        .animation(FGAnimations.bounce.delay(0.1), value: showConfetti)
                }

                Text("You're all set, \(viewModel.userName.isEmpty ? "Friend" : viewModel.userName)!")
                    .font(FGTypography.largeTitle)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Your gentle nutrition journey begins now.\nWe're here to support you every step of the way.")
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            FGButton("Start My Journey", icon: "arrow.right") {
                viewModel.completeOnboarding(appState: appState)
            }
            .padding(.horizontal, FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
        .onAppear { showConfetti = true }
    }
}
