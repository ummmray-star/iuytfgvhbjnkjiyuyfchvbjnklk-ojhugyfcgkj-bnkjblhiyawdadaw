import SwiftUI

struct PortionPickerView: View {
    @Bindable var viewModel: ManualMealViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.md) {
            Text("How much?")
                .font(FGTypography.headline)
                .foregroundStyle(FGColors.textPrimary)
                .padding(.horizontal, FGSpacing.screenPadding)

            ForEach(viewModel.selectedFoods) { food in
                HStack(spacing: FGSpacing.md) {
                    Image(systemName: food.iconName)
                        .font(.system(size: 20))
                        .foregroundStyle(food.category.accentColor)
                        .frame(width: 32)

                    Text(food.name)
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textPrimary)

                    Spacer()

                    HStack(spacing: FGSpacing.sm) {
                        ForEach(Portion.allCases) { portion in
                            let isSelected = (viewModel.selectedPortions[food.id] ?? .medium) == portion
                            Button {
                                viewModel.setPortion(portion, for: food)
                            } label: {
                                Text(portion.emoji)
                                    .font(FGTypography.captionBold)
                                    .frame(width: 40, height: 40)
                                    .background(isSelected ? FGColors.accent : FGColors.surfaceSecondary)
                                    .foregroundStyle(isSelected ? FGColors.textOnAccent : FGColors.textPrimary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                            .accessibilityLabel("\(portion.displayName) portion")
                        }
                    }
                }
                .padding(.horizontal, FGSpacing.screenPadding)
                .padding(.vertical, FGSpacing.sm)
            }
        }
        .padding(.vertical, FGSpacing.md)
        .background(FGColors.surfaceSecondary.opacity(0.5))
    }
}
