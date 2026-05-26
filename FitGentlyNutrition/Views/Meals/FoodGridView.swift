import SwiftUI

struct FoodGridView: View {
    @Bindable var viewModel: ManualMealViewModel

    private let columns = [
        GridItem(.flexible(), spacing: FGSpacing.md),
        GridItem(.flexible(), spacing: FGSpacing.md),
        GridItem(.flexible(), spacing: FGSpacing.md),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.md) {
            Text("Choose your foods")
                .font(FGTypography.headline)
                .foregroundStyle(FGColors.textPrimary)
                .padding(.horizontal, FGSpacing.screenPadding)

            LazyVGrid(columns: columns, spacing: FGSpacing.md) {
                ForEach(CommonFood.all) { food in
                    FGFoodButton(
                        food: food,
                        isSelected: viewModel.isSelected(food),
                        action: { viewModel.toggleFood(food) }
                    )
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)
        }
    }
}
