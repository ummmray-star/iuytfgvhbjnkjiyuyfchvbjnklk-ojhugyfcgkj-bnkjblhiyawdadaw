import SwiftUI

struct MealIdeaCard: View {
    let plan: MealPlan

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.md) {
                HStack {
                    VStack(alignment: .leading, spacing: FGSpacing.xs) {
                        Text(plan.title)
                            .font(FGTypography.bodyBold)
                            .foregroundStyle(FGColors.textPrimary)

                        Text(plan.description)
                            .font(FGTypography.caption)
                            .foregroundStyle(FGColors.textSecondary)
                            .lineLimit(2)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(FGColors.textSecondary)
                }

                HStack(spacing: FGSpacing.md) {
                    Label(plan.mealType, systemImage: "fork.knife")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)

                    Label("\(plan.prepTimeMinutes) min", systemImage: "clock")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)

                    Spacer()

                    HStack(spacing: FGSpacing.xs) {
                        ForEach(plan.tags.prefix(2), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .padding(.horizontal, FGSpacing.sm)
                                .padding(.vertical, FGSpacing.xs)
                                .background(FGColors.accent.opacity(0.12))
                                .foregroundStyle(FGColors.accentDark)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
    }
}
