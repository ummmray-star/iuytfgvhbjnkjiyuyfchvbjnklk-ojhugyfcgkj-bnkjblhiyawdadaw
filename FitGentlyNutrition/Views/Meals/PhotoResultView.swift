import SwiftUI

struct PhotoResultView: View {
    let image: UIImage
    let result: MealAnalysisResult
    let mealType: MealType
    let onSave: () -> Void
    let onRetake: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))
                    .fgCardShadow()

                FGCard {
                    VStack(alignment: .leading, spacing: FGSpacing.md) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundStyle(FGColors.accent)
                            Text("What we found")
                                .font(FGTypography.headline)
                                .foregroundStyle(FGColors.textPrimary)
                        }

                        ForEach(result.detectedFoods) { food in
                            HStack(spacing: FGSpacing.md) {
                                Image(systemName: food.iconName)
                                    .font(.system(size: 18))
                                    .foregroundStyle(food.category.accentColor)
                                    .frame(width: 28)

                                Text(food.name)
                                    .font(FGTypography.body)
                                    .foregroundStyle(FGColors.textPrimary)

                                Spacer()

                                Text(food.category.displayName)
                                    .font(FGTypography.caption)
                                    .foregroundStyle(FGColors.textSecondary)
                            }
                        }
                    }
                }

                FGCard {
                    HStack(spacing: FGSpacing.md) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(FGColors.warmOrange)

                        Text(result.feedback)
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textPrimary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                VStack(spacing: FGSpacing.md) {
                    FGButton("Save This Meal", icon: "checkmark", action: onSave)
                    FGButton("Retake Photo", icon: "camera", style: .outline, action: onRetake)
                }
            }
            .padding(FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
    }
}
