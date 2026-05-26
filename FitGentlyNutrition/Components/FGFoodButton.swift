import SwiftUI

struct FGFoodButton: View {
    let food: CommonFood
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: FGSpacing.sm) {
                ZStack {
                    Circle()
                        .fill(isSelected ? food.category.accentColor : food.category.accentColor.opacity(0.15))
                        .frame(width: 64, height: 64)

                    Image(systemName: food.iconName)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(isSelected ? .white : food.category.accentColor)
                }

                Text(food.name)
                    .font(FGTypography.captionBold)
                    .foregroundStyle(FGColors.textPrimary)
            }
            .frame(minWidth: 80, minHeight: 100)
            .padding(FGSpacing.sm)
            .background(isSelected ? food.category.accentColor.opacity(0.1) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                        .strokeBorder(food.category.accentColor, lineWidth: 2)
                }
            }
        }
        .accessibilityLabel("\(food.name), \(food.category.displayName)")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
