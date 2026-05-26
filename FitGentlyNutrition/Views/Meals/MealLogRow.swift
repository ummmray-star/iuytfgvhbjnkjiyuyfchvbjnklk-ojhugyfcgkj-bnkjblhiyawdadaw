import SwiftUI

struct MealLogRow: View {
    let meal: MealEntry

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            ZStack {
                Circle()
                    .fill(mealColor.opacity(0.15))
                    .frame(width: 48, height: 48)

                Image(systemName: meal.mealType.iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(mealColor)
            }

            VStack(alignment: .leading, spacing: FGSpacing.xs) {
                Text(meal.mealType.displayName)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(FGColors.textPrimary)

                Text(meal.foodSummary.isEmpty ? "Meal logged" : meal.foodSummary)
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: FGSpacing.xs) {
                Text(meal.timestamp.shortTime)
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)

                if meal.isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(FGColors.warmOrange)
                }
            }
        }
        .padding(.vertical, FGSpacing.sm)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(meal.mealType.displayName) at \(meal.timestamp.shortTime). \(meal.foodSummary)")
    }

    private var mealColor: Color {
        switch meal.mealType {
        case .breakfast: return FGColors.warmOrange
        case .lunch: return FGColors.accent
        case .dinner: return FGColors.hydrationBlue
        case .snack: return FGColors.surfaceSecondary
        }
    }
}
