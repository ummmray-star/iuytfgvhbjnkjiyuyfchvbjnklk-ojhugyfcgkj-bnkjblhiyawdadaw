import SwiftUI
import SwiftData

struct ManualMealView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ManualMealViewModel()
    let onSave: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.xl) {

                // MARK: Meal type picker — big, clear cards
                VStack(alignment: .leading, spacing: FGSpacing.md) {
                    Text("What meal is this?")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)

                    VStack(spacing: FGSpacing.sm) {
                        ForEach(MealType.allCases) { type in
                            MealTypeCard(
                                type: type,
                                isSelected: viewModel.mealType == type,
                                action: { viewModel.mealType = type }
                            )
                        }
                    }
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                // MARK: Food grid
                FoodGridView(viewModel: viewModel)

                // MARK: Portion picker (appears after a food is chosen)
                if !viewModel.selectedFoods.isEmpty {
                    PortionPickerView(viewModel: viewModel)
                }

                // MARK: Save button
                FGButton("Save Meal", icon: "checkmark", style: .primary) {
                    let meal = viewModel.buildMealEntry()
                    modelContext.insert(meal)
                    HapticService.success()
                    onSave()
                }
                .disabled(!viewModel.canSave)
                .opacity(viewModel.canSave ? 1.0 : 0.45)
                .padding(.horizontal, FGSpacing.screenPadding)
                .padding(.bottom, FGSpacing.xxl)
            }
            .padding(.top, FGSpacing.lg)
        }
        .background(FGColors.background)
        .navigationTitle("Log a Meal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - MealTypeCard

private struct MealTypeCard: View {
    let type: MealType
    let isSelected: Bool
    let action: () -> Void

    private var cardColor: Color {
        switch type {
        case .breakfast: return FGColors.warmOrange
        case .lunch:     return FGColors.accent
        case .dinner:    return FGColors.hydrationBlue
        case .snack:     return Color(hex: "4A7C59")
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: FGSpacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(cardColor.opacity(isSelected ? 1.0 : 0.15))
                        .frame(width: 52, height: 52)
                    Image(systemName: type.iconName)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(isSelected ? .white : cardColor)
                }

                Text(type.displayName)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(FGColors.textPrimary)

                Spacer()

                ZStack {
                    Circle()
                        .fill(isSelected ? cardColor : FGColors.divider.opacity(0.6))
                        .frame(width: 28, height: 28)
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(FGSpacing.md)
            .frame(minHeight: 70)
            .background(isSelected ? cardColor.opacity(0.08) : FGColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                    .strokeBorder(isSelected ? cardColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
