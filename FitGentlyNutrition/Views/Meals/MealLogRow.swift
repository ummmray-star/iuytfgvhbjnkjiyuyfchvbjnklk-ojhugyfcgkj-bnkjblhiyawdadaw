import SwiftUI

struct MealLogRow: View {
    let meal: MealEntry

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            // Thumbnail placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(mealColor.opacity(0.12))
                    .frame(width: 60, height: 60)

                Image(systemName: meal.mealType.iconName)
                    .font(.system(size: 26, weight: .semibold))
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

                if let kcal = estimatedKcal, kcal > 0 {
                    Text("~\(kcal) kcal")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary.opacity(0.7))
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
        case .snack: return Color(hex: "#4A7C59")
        }
    }

    // Rough estimate based on portion size and food category
    private var estimatedKcal: Int? {
        guard !meal.foods.isEmpty else { return nil }
        let total = meal.foods.reduce(0) { sum, food in
            let base: Int
            switch food.category {
            case .protein: base = 180
            case .grain: base = 200
            case .vegetable: base = 50
            case .fruit: base = 70
            case .dairy: base = 120
            case .liquid: base = 10
            case .other: base = 100
            }
            let multiplier: Double
            switch food.portion {
            case .small: multiplier = 0.6
            case .medium: multiplier = 1.0
            case .large: multiplier = 1.5
            }
            return sum + Int(Double(base) * multiplier)
        }
        return total
    }
}
