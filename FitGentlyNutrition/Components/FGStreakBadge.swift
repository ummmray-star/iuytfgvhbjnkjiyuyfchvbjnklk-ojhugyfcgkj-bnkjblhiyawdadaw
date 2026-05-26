import SwiftUI

struct FGStreakBadge: View {
    let count: Int
    let label: String

    var body: some View {
        HStack(spacing: FGSpacing.sm) {
            Image(systemName: "flame.fill")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(FGColors.warmOrange)

            Text("\(count) \(label)")
                .font(FGTypography.captionBold)
                .foregroundStyle(FGColors.textPrimary)
        }
        .padding(.horizontal, FGSpacing.md)
        .padding(.vertical, FGSpacing.sm)
        .background(FGColors.warmOrange.opacity(0.12))
        .clipShape(Capsule())
        .accessibilityLabel("\(count) day \(label) streak")
    }
}
