import SwiftUI

struct HabitSummaryCard: View {
    let averageScore: Int
    let totalMeals: Int

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.md) {
                Text("Weekly Summary")
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)

                HStack(spacing: FGSpacing.xl) {
                    SummaryItem(
                        label: "Avg Score",
                        value: "\(averageScore)",
                        icon: "chart.bar.fill",
                        color: FGColors.accent
                    )

                    SummaryItem(
                        label: "Meals Logged",
                        value: "\(totalMeals)",
                        icon: "fork.knife",
                        color: FGColors.warmOrange
                    )
                }

                Text(summaryMessage)
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var summaryMessage: String {
        if averageScore >= 70 { return "Excellent week! Your nutrition has been very consistent." }
        if averageScore >= 50 { return "Good progress this week. Keep building those habits." }
        if totalMeals == 0 { return "Start logging to see your weekly summary here." }
        return "Every meal logged is a step forward. You're doing great."
    }
}

private struct SummaryItem: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(color)

            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)
                Text(label)
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }
        }
    }
}
