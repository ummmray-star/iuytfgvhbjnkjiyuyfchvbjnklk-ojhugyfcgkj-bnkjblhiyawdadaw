import SwiftUI

struct DietaryStepView: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: FGSpacing.xl) {
            Spacer()

            VStack(spacing: FGSpacing.md) {
                Image(systemName: "leaf.fill")
                    .font(.system(size: 48, weight: .light))
                    .foregroundStyle(FGColors.accent)

                Text("Any dietary needs?")
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("This helps us personalize your experience.")
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
            }

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: FGSpacing.md) {
                ForEach(viewModel.availableRestrictions, id: \.self) { restriction in
                    let isSelected = viewModel.dietaryRestrictions.contains(restriction)

                    Button {
                        if restriction == "No restrictions" {
                            viewModel.dietaryRestrictions = ["No restrictions"]
                        } else {
                            viewModel.dietaryRestrictions.remove("No restrictions")
                            if isSelected {
                                viewModel.dietaryRestrictions.remove(restriction)
                            } else {
                                viewModel.dietaryRestrictions.insert(restriction)
                            }
                        }
                        HapticService.selection()
                    } label: {
                        Text(restriction)
                            .font(FGTypography.captionBold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, FGSpacing.md)
                            .background(isSelected ? FGColors.accent : FGColors.surface)
                            .foregroundStyle(isSelected ? FGColors.textOnAccent : FGColors.textPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
                            .fgCardShadow()
                    }
                    .accessibleTapTarget()
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            Spacer()

            HStack {
                Button("Skip") { viewModel.skip() }
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)

                Spacer()

                FGButton("Continue", icon: "arrow.right") {
                    viewModel.advance()
                }
                .frame(maxWidth: 180)
            }
            .padding(.horizontal, FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
    }
}
