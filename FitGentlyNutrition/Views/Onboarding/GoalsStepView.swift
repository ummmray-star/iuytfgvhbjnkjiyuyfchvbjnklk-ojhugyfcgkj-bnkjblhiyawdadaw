import SwiftUI

struct GoalsStepView: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: FGSpacing.xl) {
                    Spacer(minLength: FGSpacing.lg)

                    // Header
                    VStack(spacing: FGSpacing.md) {
                        ZStack {
                            Circle()
                                .fill(FGColors.accent.opacity(0.15))
                                .frame(width: 80, height: 80)
                            Image(systemName: "heart.fill")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundStyle(FGColors.accent)
                        }

                        Text("What matters most\nto you?")
                            .font(FGTypography.title)
                            .foregroundStyle(FGColors.textPrimary)
                            .multilineTextAlignment(.center)

                        Text("Choose as many as you like.")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                    }
                    .padding(.horizontal, FGSpacing.screenPadding)

                    // Goal options
                    VStack(spacing: FGSpacing.sm) {
                        ForEach(viewModel.availableGoals, id: \.self) { goal in
                            GoalRow(
                                label: goal,
                                isSelected: viewModel.selectedGoals.contains(goal)
                            ) {
                                if viewModel.selectedGoals.contains(goal) {
                                    viewModel.selectedGoals.remove(goal)
                                } else {
                                    viewModel.selectedGoals.insert(goal)
                                }
                                HapticService.selection()
                            }
                        }
                    }
                    .padding(.horizontal, FGSpacing.screenPadding)

                    Spacer(minLength: FGSpacing.lg)
                }
            }

            // Bottom nav
            bottomNav
        }
    }

    private var bottomNav: some View {
        HStack(spacing: FGSpacing.md) {
            Button("Skip") { viewModel.skip() }
                .font(FGTypography.body)
                .foregroundStyle(FGColors.textSecondary)
                .frame(minHeight: FGSpacing.touchTarget)

            Spacer()

            FGButton("Continue", icon: "arrow.right") {
                viewModel.advance()
            }
            .frame(maxWidth: 200)
        }
        .padding(.horizontal, FGSpacing.screenPadding)
        .padding(.vertical, FGSpacing.md)
        .background(FGColors.background)
    }
}

// MARK: - GoalRow

private struct GoalRow: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: FGSpacing.md) {
                ZStack {
                    Circle()
                        .fill(isSelected ? FGColors.accent : FGColors.divider.opacity(0.5))
                        .frame(width: 32, height: 32)
                    Image(systemName: isSelected ? "checkmark" : "")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(FGColors.textOnAccent)
                }

                Text(label)
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding(FGSpacing.md)
            .frame(minHeight: 60)
            .background(isSelected ? FGColors.accent.opacity(0.08) : FGColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                    .strokeBorder(isSelected ? FGColors.accent : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
