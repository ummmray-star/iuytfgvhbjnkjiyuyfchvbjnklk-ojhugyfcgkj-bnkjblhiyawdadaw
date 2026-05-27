import SwiftUI

struct FoodGridView: View {
    @Bindable var viewModel: ManualMealViewModel

    // 2 columns — bigger buttons, easier to tap
    private let columns = [
        GridItem(.flexible(), spacing: FGSpacing.md),
        GridItem(.flexible(), spacing: FGSpacing.md),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.md) {
            VStack(alignment: .leading, spacing: FGSpacing.xs) {
                Text("Choose your foods")
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)

                Text("Tap everything you're eating.")
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            LazyVGrid(columns: columns, spacing: FGSpacing.md) {
                ForEach(CommonFood.all) { food in
                    FGFoodButton(
                        food: food,
                        isSelected: viewModel.isSelected(food),
                        action: {
                            viewModel.toggleFood(food)
                            HapticService.selection()
                        }
                    )
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)
        }
    }
}
