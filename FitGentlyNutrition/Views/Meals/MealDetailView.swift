import SwiftUI

struct MealDetailView: View {
    let meal: MealEntry

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                if let photoData = meal.photoData, let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 250)
                        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))
                        .fgCardShadow()
                }

                FGCard {
                    VStack(alignment: .leading, spacing: FGSpacing.md) {
                        HStack {
                            Image(systemName: meal.mealType.iconName)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(FGColors.accent)

                            Text(meal.mealType.displayName)
                                .font(FGTypography.headline)
                                .foregroundStyle(FGColors.textPrimary)

                            Spacer()

                            Text(meal.timestamp.friendlyDate)
                                .font(FGTypography.caption)
                                .foregroundStyle(FGColors.textSecondary)
                        }

                        Text(meal.timestamp.shortTime)
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                    }
                }

                FGCard {
                    VStack(alignment: .leading, spacing: FGSpacing.md) {
                        Text("Foods")
                            .font(FGTypography.headline)
                            .foregroundStyle(FGColors.textPrimary)

                        if meal.foods.isEmpty {
                            Text("No specific foods recorded.")
                                .font(FGTypography.body)
                                .foregroundStyle(FGColors.textSecondary)
                        } else {
                            ForEach(meal.foods) { food in
                                HStack(spacing: FGSpacing.md) {
                                    Image(systemName: food.iconName)
                                        .font(.system(size: 18))
                                        .foregroundStyle(food.category.accentColor)
                                        .frame(width: 28)

                                    Text(food.name)
                                        .font(FGTypography.body)
                                        .foregroundStyle(FGColors.textPrimary)

                                    Spacer()

                                    Text(food.portion.displayName)
                                        .font(FGTypography.caption)
                                        .foregroundStyle(FGColors.textSecondary)
                                        .padding(.horizontal, FGSpacing.sm)
                                        .padding(.vertical, FGSpacing.xs)
                                        .background(FGColors.surfaceSecondary)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                }

                if let feedback = meal.aiFeedback {
                    FGCard {
                        HStack(spacing: FGSpacing.md) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 22))
                                .foregroundStyle(FGColors.warmOrange)

                            Text(feedback)
                                .font(FGTypography.body)
                                .foregroundStyle(FGColors.textPrimary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            .padding(FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationTitle("Meal Details")
    }
}
