import SwiftUI

struct WelcomeStepView: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: FGSpacing.xl) {
            Spacer()

            VStack(spacing: FGSpacing.lg) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 72, weight: .light))
                    .foregroundStyle(FGColors.accent)

                Text("Welcome to\nFitGently Nutrition")
                    .font(FGTypography.largeTitle)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Your gentle daily nutrition companion.\nSimple, supportive, and made for you.")
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            VStack(spacing: FGSpacing.md) {
                Text("What should we call you?")
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)

                TextField("Your name", text: $viewModel.userName)
                    .font(FGTypography.body)
                    .padding(FGSpacing.md)
                    .background(FGColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
                    .fgCardShadow()
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, FGSpacing.xl)

            FGButton("Get Started", icon: "arrow.right") {
                viewModel.advance()
            }
            .padding(.horizontal, FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
    }
}
