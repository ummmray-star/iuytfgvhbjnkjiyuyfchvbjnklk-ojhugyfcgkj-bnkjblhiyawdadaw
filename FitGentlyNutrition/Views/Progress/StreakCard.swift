import SwiftUI

struct StreakCard: View {
    let title: String
    let count: Int
    let icon: String
    let color: Color

    var body: some View {
        FGCard {
            VStack(spacing: FGSpacing.md) {
                Image(systemName: icon)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(color)

                Text("\(count)")
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)
                    .contentTransition(.numericText())

                Text(title)
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)

                Text(count == 1 ? "day" : "days")
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
