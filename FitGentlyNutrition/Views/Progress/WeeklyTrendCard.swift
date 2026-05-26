import SwiftUI

struct WeeklyTrendCard: View {
    let scores: [(date: Date, score: Int)]

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.md) {
                Text("Nourishment Trend")
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)

                HStack(alignment: .bottom, spacing: FGSpacing.sm) {
                    ForEach(scores.indices, id: \.self) { index in
                        let entry = scores[index]
                        VStack(spacing: FGSpacing.xs) {
                            Text("\(entry.score)")
                                .font(FGTypography.caption)
                                .foregroundStyle(FGColors.textSecondary)

                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(barColor(for: entry.score))
                                .frame(height: max(CGFloat(entry.score) * 1.2, 8))

                            Text(entry.date.dayOfWeekShort)
                                .font(FGTypography.caption)
                                .foregroundStyle(FGColors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 150)
            }
        }
    }

    private func barColor(for score: Int) -> Color {
        if score >= 70 { return FGColors.accent }
        if score >= 40 { return FGColors.warmOrange }
        return FGColors.divider
    }
}
