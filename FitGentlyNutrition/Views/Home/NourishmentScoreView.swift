import SwiftUI

struct NourishmentScoreView: View {
    let score: NutritionScore

    var body: some View {
        FGCard {
            VStack(spacing: FGSpacing.lg) {
                Text("Today's Nourishment")
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)

                FGProgressRing(
                    progress: Double(score.total) / 100.0,
                    size: 180,
                    lineWidth: 16,
                    label: "score"
                )

                Text(score.feedback)
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .multilineTextAlignment(.center)

                HStack(spacing: FGSpacing.lg) {
                    ScoreBreakdownItem(label: "Variety", value: score.varietyScore, max: 40)
                    ScoreBreakdownItem(label: "Protein", value: score.proteinScore, max: 25)
                    ScoreBreakdownItem(label: "Produce", value: score.produceScore, max: 20)
                    ScoreBreakdownItem(label: "Meals", value: score.regularityScore, max: 15)
                }
            }
        }
    }
}

private struct ScoreBreakdownItem: View {
    let label: String
    let value: Int
    let max: Int

    var body: some View {
        VStack(spacing: FGSpacing.xs) {
            Text("\(value)")
                .font(FGTypography.bodyBold)
                .foregroundStyle(FGColors.textPrimary)
                .contentTransition(.numericText())

            Text(label)
                .font(FGTypography.caption)
                .foregroundStyle(FGColors.textSecondary)

            FGProgressBar(
                progress: Double(value) / Double(max),
                color: FGColors.accent,
                height: 6
            )
            .frame(width: 50)
        }
    }
}
