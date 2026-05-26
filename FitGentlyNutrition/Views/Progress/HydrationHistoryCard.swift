import SwiftUI

struct HydrationHistoryCard: View {
    let hydration: [(date: Date, glasses: Int)]
    let goal: Int

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.md) {
                HStack {
                    Image(systemName: "drop.fill")
                        .foregroundStyle(FGColors.hydrationBlue)
                    Text("Hydration This Week")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)
                }

                HStack(alignment: .bottom, spacing: FGSpacing.sm) {
                    ForEach(hydration.indices, id: \.self) { index in
                        let entry = hydration[index]
                        let progress = goal > 0 ? Double(entry.glasses) / Double(goal) : 0

                        VStack(spacing: FGSpacing.xs) {
                            Text("\(entry.glasses)")
                                .font(FGTypography.caption)
                                .foregroundStyle(FGColors.textSecondary)

                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(FGColors.hydrationBlue.opacity(0.15))
                                    .frame(height: 80)

                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(FGColors.hydrationBlue)
                                    .frame(height: max(CGFloat(progress) * 80, 4))
                            }

                            Text(entry.date.dayOfWeekShort)
                                .font(FGTypography.caption)
                                .foregroundStyle(FGColors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}
