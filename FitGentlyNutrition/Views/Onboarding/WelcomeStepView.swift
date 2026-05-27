import SwiftUI

struct WelcomeStepView: View {
    @Bindable var viewModel: OnboardingViewModel
    @FocusState private var nameFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.xl) {
                Spacer(minLength: FGSpacing.xxl)

                // Logo / illustration
                VStack(spacing: FGSpacing.lg) {
                    ZStack {
                        Circle()
                            .fill(FGColors.accent.opacity(0.15))
                            .frame(width: 110, height: 110)
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 52, weight: .medium))
                            .foregroundStyle(FGColors.accent)
                    }

                    VStack(spacing: FGSpacing.sm) {
                        Text("Welcome to\nFitGently Nutrition")
                            .font(FGTypography.largeTitle)
                            .foregroundStyle(FGColors.textPrimary)
                            .multilineTextAlignment(.center)

                        Text("Your gentle daily companion\nfor healthy eating habits.")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                }

                // Name field
                VStack(alignment: .leading, spacing: FGSpacing.md) {
                    Text("What should we call you?")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)

                    TextField("Your first name", text: $viewModel.userName)
                        .font(FGTypography.body)
                        .padding(FGSpacing.md)
                        .frame(minHeight: 56)
                        .background(FGColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                                .strokeBorder(nameFocused ? FGColors.accent : FGColors.divider, lineWidth: 2)
                        )
                        .focused($nameFocused)
                        .submitLabel(.done)
                        .onSubmit { nameFocused = false }
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                // CTA
                FGButton("Get Started", icon: "arrow.right") {
                    nameFocused = false
                    viewModel.advance()
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                Spacer(minLength: FGSpacing.xxl)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .onTapGesture { nameFocused = false }
    }
}
