import SwiftUI
import SwiftData

struct ManualMealView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ManualMealViewModel()
    let onSave: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                VStack(alignment: .leading, spacing: FGSpacing.md) {
                    Text("What meal is this?")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)

                    HStack(spacing: FGSpacing.sm) {
                        ForEach(MealType.allCases) { type in
                            MealTypeChip(
                                type: type,
                                isSelected: viewModel.mealType == type,
                                action: { viewModel.mealType = type }
                            )
                        }
                    }
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                FoodGridView(viewModel: viewModel)

                if !viewModel.selectedFoods.isEmpty {
                    PortionPickerView(viewModel: viewModel)
                }

                FGButton("Save Meal", icon: "checkmark", style: .primary) {
                    let meal = viewModel.buildMealEntry()
                    modelContext.insert(meal)
                    HapticService.success()
                    onSave()
                }
                .disabled(!viewModel.canSave)
                .opacity(viewModel.canSave ? 1.0 : 0.5)
                .padding(.horizontal, FGSpacing.screenPadding)
                .padding(.bottom, FGSpacing.xxl)
            }
            .padding(.top, FGSpacing.md)
        }
        .background(FGColors.background)
        .navigationTitle("Log Meal")
    }
}

private struct MealTypeChip: View {
    let type: MealType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: FGSpacing.xs) {
                Image(systemName: type.iconName)
                    .font(.system(size: 14, weight: .semibold))
                Text(type.displayName)
                    .font(FGTypography.captionBold)
            }
            .padding(.horizontal, FGSpacing.md)
            .padding(.vertical, FGSpacing.sm)
            .background(isSelected ? FGColors.accent : FGColors.surfaceSecondary)
            .foregroundStyle(isSelected ? FGColors.textOnAccent : FGColors.textPrimary)
            .clipShape(Capsule())
        }
        .accessibleTapTarget()
    }
}
