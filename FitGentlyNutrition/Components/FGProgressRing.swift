import SwiftUI

struct FGProgressRing: View {
    let progress: Double
    let lineWidth: CGFloat
    let size: CGFloat
    let color: Color
    let label: String?

    init(progress: Double, size: CGFloat = 160, lineWidth: CGFloat = 14, color: Color = FGColors.accent, label: String? = nil) {
        self.progress = min(max(progress, 0), 1)
        self.size = size
        self.lineWidth = lineWidth
        self.color = color
        self.label = label
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.15), lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(FGAnimations.slow, value: progress)

            VStack(spacing: FGSpacing.xs) {
                Text("\(Int(progress * 100))")
                    .font(FGTypography.scoreDisplay)
                    .foregroundStyle(FGColors.textPrimary)
                    .contentTransition(.numericText())

                if let label {
                    Text(label)
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }
            }
        }
        .frame(width: size, height: size)
        .accessibilityElement()
        .accessibilityLabel("\(label ?? "Score"): \(Int(progress * 100)) percent")
    }
}
