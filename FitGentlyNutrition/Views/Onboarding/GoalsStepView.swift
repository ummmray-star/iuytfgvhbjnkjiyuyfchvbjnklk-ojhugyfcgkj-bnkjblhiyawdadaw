import SwiftUI

struct GoalsStepView: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: FGSpacing.xl) {
            Spacer()

            VStack(spacing: FGSpacing.md) {
                Image(systemName: "target")
                    .font(.system(size: 48, weight: .light))
                    .foregroundStyle(FGColors.accent)

                Text("What matters most to you?")
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text("Choose as many as you like.")
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
            }

            VStack(spacing: FGSpacing.md) {
                ForEach(viewModel.availableGoals, id: \.self) { goal in
                    let isSelected = viewModel.selectedGoals.contains(goal)

                    Button {
                        if isSelected {
                            viewModel.selectedGoals.remove(goal)
                        } else {
                            viewModel.selectedGoals.insert(goal)
                        }
                        HapticService.selection()
                    } label: {
                        HStack(spacing: FGSpacing.md) {
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 24))
                                .foregroundStyle(isSelected ? FGColors.accent : FGColors.divider)

                            Text(goal)
                                .font(FGTypography.body)
                                .foregroundStyle(FGColors.textPrimary)

                            Spacer()
                        }
                        .padding(FGSpacing.md)
                        .background(isSelected ? FGColors.accent.opacity(0.08) : FGColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
                        .overlay {
                            if isSelected {
                                RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                                    .strokeBorder(FGColors.accent, lineWidth: 1.5)
                            }
                        }
                    }
                    .accessibleTapTarget()
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            Spacer()

            HStack {
                Button("Skip") {
                    viewModel.skip()
                }
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
