import SwiftUI

struct TodaysHealthView: View {
    let score: NutritionScore
    let todayGlasses: Int
    let hydrationGoal: Int
    let mealCount: Int

    var body: some View {
        FGCard {
            VStack(spacing: 0) {
                HStack {
                    Text("Today's Health")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)
                    Spacer()
                }
                .padding(.bottom, FGSpacing.md)

                VStack(spacing: 0) {
                    HealthRow(
                        icon: "🟢",
                        title: "Protein",
                        status: proteinStatus,
                        statusColor: proteinColor
                    )

                    Divider().padding(.leading, 44)

                    HealthRow(
                        icon: "🍊",
                        title: "Fruits & Veggies",
                        status: produceStatus,
                        statusColor: produceColor
                    )

                    Divider().padding(.leading, 44)

                    HealthRow(
                        icon: "💧",
                        title: "Water",
                        status: waterStatus,
                        statusColor: waterColor
                    )

                    Divider().padding(.leading, 44)

                    HealthRow(
                        icon: "🍽️",
                        title: "Meal Balance",
                        status: mealBalanceStatus,
                        statusColor: mealBalanceColor,
                        isLast: true
                    )
                }
            }
        }
    }

    // MARK: - Protein
    private var hasProtein: Bool { score.proteinScore > 0 }
    private var proteinStatus: String { hasProtein ? "Great job!" : "Try adding some protein." }
    private var proteinColor: Color { hasProtein ? .green : FGColors.warmOrange }

    // MARK: - Produce
    private var hasProduce: Bool { score.produceScore >= 10 }
    private var produceStatus: String { hasProduce ? "Great job!" : "Try to add more today." }
    private var produceColor: Color { hasProduce ? .green : FGColors.warmOrange }

    // MARK: - Water
    private var waterStatus: String {
        if todayGlasses >= hydrationGoal { return "Goal complete! 🎉" }
        return "\(todayGlasses) of \(hydrationGoal) cups"
    }
    private var waterColor: Color { todayGlasses >= hydrationGoal ? .green : FGColors.hydrationBlue }

    // MARK: - Meal Balance
    private var mealBalanceStatus: String {
        if mealCount == 0 { return "Log your first meal!" }
        if mealCount >= 3 { return "Doing great!" }
        return "Doing okay — keep going."
    }
    private var mealBalanceColor: Color {
        if mealCount == 0 { return FGColors.warmOrange }
        if mealCount >= 3 { return .green }
        return FGColors.accent
    }
}

// MARK: - HealthRow

private struct HealthRow: View {
    let icon: String
    let title: String
    let status: String
    let statusColor: Color
    var isLast: Bool = false

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            Text(icon)
                .font(.system(size: 24))
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(FGColors.textPrimary)

                Text(status)
                    .font(FGTypography.caption)
                    .foregroundStyle(statusColor)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(FGColors.textSecondary.opacity(0.5))
        }
        .padding(.vertical, FGSpacing.md)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(status)")
    }
}
