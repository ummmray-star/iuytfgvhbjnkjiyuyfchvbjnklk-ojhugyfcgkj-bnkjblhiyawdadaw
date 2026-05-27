import SwiftUI

struct PortionPickerView: View {
    @Bindable var viewModel: ManualMealViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.md) {
            // Section title
            VStack(alignment: .leading, spacing: FGSpacing.xs) {
                Text("How much did you have?")
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)
                Text("Pick the closest amount for each food.")
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            VStack(spacing: FGSpacing.sm) {
                ForEach(viewModel.selectedFoods) { food in
                    FoodPortionRow(
                        food: food,
                        selectedPortion: viewModel.selectedPortions[food.id] ?? .medium,
                        onSelect: { portion in
                            viewModel.setPortion(portion, for: food)
                            HapticService.selection()
                        }
                    )
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)
        }
        .padding(.vertical, FGSpacing.lg)
        .background(FGColors.surfaceSecondary.opacity(0.6))
    }
}

// MARK: - FoodPortionRow

private struct FoodPortionRow: View {
    let food: CommonFood
    let selectedPortion: Portion
    let onSelect: (Portion) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.sm) {
            // Food label
            HStack(spacing: FGSpacing.sm) {
                Image(systemName: food.iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(food.category.accentColor)
                    .frame(width: 28)

                Text(food.name)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(FGColors.textPrimary)
            }

            // Three big portion buttons
            HStack(spacing: FGSpacing.sm) {
                ForEach(Portion.allCases) { portion in
                    PortionButton(
                        portion: portion,
                        isSelected: selectedPortion == portion,
                        action: { onSelect(portion) }
                    )
                }
            }
        }
        .padding(FGSpacing.md)
        .background(FGColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

// MARK: - PortionButton

private struct PortionButton: View {
    let portion: Portion
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: FGSpacing.xs) {
                Text(portion.emoji)
                    .font(.system(size: 28))

                Text(portion.displayName)
                    .font(FGTypography.captionBold)
                    .foregroundStyle(isSelected ? FGColors.textOnAccent : FGColors.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 76)
            .background(isSelected ? FGColors.accent : FGColors.surfaceSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(isSelected ? FGColors.accentDark : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(portion.displayName) portion\(isSelected ? ", selected" : "")")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
