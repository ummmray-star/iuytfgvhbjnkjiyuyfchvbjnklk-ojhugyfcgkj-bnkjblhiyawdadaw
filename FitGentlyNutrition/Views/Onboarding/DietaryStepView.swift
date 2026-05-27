import SwiftUI

struct DietaryStepView: View {
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
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundStyle(FGColors.accent)
                        }

                        Text("Any dietary needs?")
                            .font(FGTypography.title)
                            .foregroundStyle(FGColors.textPrimary)
                            .multilineTextAlignment(.center)

                        Text("This helps us personalise your experience.\nYou can change this later.")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, FGSpacing.screenPadding)

                    // Full-width list — same pattern as GoalsStepView
                    VStack(spacing: FGSpacing.sm) {
                        ForEach(viewModel.availableRestrictions, id: \.self) { restriction in
                            DietaryRow(
                                label: restriction,
                                isSelected: viewModel.dietaryRestrictions.contains(restriction)
                            ) {
                                if restriction == "No restrictions" {
                                    viewModel.dietaryRestrictions = ["No restrictions"]
                                } else {
                                    viewModel.dietaryRestrictions.remove("No restrictions")
                                    if viewModel.dietaryRestrictions.contains(restriction) {
                                        viewModel.dietaryRestrictions.remove(restriction)
                                    } else {
                                        viewModel.dietaryRestrictions.insert(restriction)
                                    }
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

// MARK: - DietaryRow

private struct DietaryRow: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    // Map label → friendly emoji
    private var emoji: String {
        switch label {
        case "Vegetarian":      return "🥦"
        case "Low sodium":      return "🧂"
        case "Dairy free":      return "🥛"
        case "Gluten free":     return "🌾"
        case "Diabetic friendly": return "💙"
        case "No restrictions": return "✅"
        default:                return "🍽️"
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: FGSpacing.md) {
                Text(emoji)
                    .font(.system(size: 26))
                    .frame(width: 40, height: 40)

                Text(label)
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.leading)

                Spacer()

                ZStack {
                    Circle()
                        .fill(isSelected ? FGColors.accent : FGColors.divider.opacity(0.5))
                        .frame(width: 28, height: 28)
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(FGColors.textOnAccent)
                    }
                }
            }
            .padding(FGSpacing.md)
            .frame(minHeight: 64)
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
