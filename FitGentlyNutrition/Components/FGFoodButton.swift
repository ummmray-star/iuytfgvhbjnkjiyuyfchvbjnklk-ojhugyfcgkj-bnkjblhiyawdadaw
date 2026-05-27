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
                        .fill(isSelected ? food.category.accentColor : food.category.accentColor.opacity(0.12))
                        .frame(width: 72, height: 72)

                    Image(systemName: food.iconName)
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(isSelected ? .white : food.category.accentColor)
                }

                Text(food.name)
                    .font(FGTypography.captionBold)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 120)
            .padding(.vertical, FGSpacing.md)
            .padding(.horizontal, FGSpacing.sm)
            .background(isSelected ? food.category.accentColor.opacity(0.1) : FGColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                    .strokeBorder(isSelected ? food.category.accentColor : FGColors.divider, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(food.name), \(food.category.displayName)\(isSelected ? ", selected" : "")")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
