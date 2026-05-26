import SwiftUI

struct RecipeDetailView: View {
    let plan: MealPlan

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: FGSpacing.lg) {
                VStack(alignment: .leading, spacing: FGSpacing.sm) {
                    Text(plan.title)
                        .font(FGTypography.largeTitle)
                        .foregroundStyle(FGColors.textPrimary)

                    Text(plan.description)
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)

                    HStack(spacing: FGSpacing.lg) {
                        Label(plan.mealType, systemImage: "fork.knife")
                        Label("\(plan.prepTimeMinutes) min", systemImage: "clock")
                    }
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
                    .padding(.top, FGSpacing.xs)
                }

                FGCard {
                    VStack(alignment: .leading, spacing: FGSpacing.md) {
                        Text("Ingredients")
                            .font(FGTypography.headline)
                            .foregroundStyle(FGColors.textPrimary)

                        ForEach(plan.ingredients, id: \.self) { ingredient in
                            HStack(spacing: FGSpacing.md) {
                                Circle()
                                    .fill(FGColors.accent)
                                    .frame(width: 8, height: 8)

                                Text(ingredient)
                                    .font(FGTypography.body)
                                    .foregroundStyle(FGColors.textPrimary)
                            }
                        }
                    }
                }

                FGCard {
                    VStack(alignment: .leading, spacing: FGSpacing.md) {
                        Text("Steps")
                            .font(FGTypography.headline)
                            .foregroundStyle(FGColors.textPrimary)

                        ForEach(Array(plan.steps.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: FGSpacing.md) {
                                Text("\(index + 1)")
                                    .font(FGTypography.bodyBold)
                                    .foregroundStyle(FGColors.accent)
                                    .frame(width: 28, height: 28)
                                    .background(FGColors.accent.opacity(0.12))
                                    .clipShape(Circle())

                                Text(step)
                                    .font(FGTypography.body)
                                    .foregroundStyle(FGColors.textPrimary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
            }
            .padding(FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationBarTitleDisplayMode(.inline)
    }
}
