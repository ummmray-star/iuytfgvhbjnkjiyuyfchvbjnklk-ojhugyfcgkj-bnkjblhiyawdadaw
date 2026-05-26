import SwiftUI

struct FGGlassCounter: View {
    let current: Int
    let goal: Int
    let onAdd: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(spacing: FGSpacing.md) {
            HStack(spacing: FGSpacing.sm) {
                ForEach(0..<goal, id: \.self) { index in
                    GlassIcon(isFilled: index < current)
                        .animation(FGAnimations.spring.delay(Double(index) * 0.05), value: current)
                }
            }

            HStack(spacing: FGSpacing.lg) {
                Button(action: onRemove) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(current > 0 ? FGColors.hydrationBlue : FGColors.divider)
                }
                .disabled(current <= 0)
                .accessibilityLabel("Remove one glass")

                Text("\(current) of \(goal)")
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(FGColors.textPrimary)
                    .contentTransition(.numericText())

                Button(action: onAdd) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(current < goal ? FGColors.hydrationBlue : FGColors.divider)
                }
                .disabled(current >= goal)
                .accessibilityLabel("Add one glass")
            }
            .accessibleTapTarget()
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Water intake: \(current) of \(goal) glasses")
    }
}

private struct GlassIcon: View {
    let isFilled: Bool

    var body: some View {
        Image(systemName: isFilled ? "drop.fill" : "drop")
            .font(.system(size: 24, weight: .medium))
            .foregroundStyle(isFilled ? FGColors.hydrationBlue : FGColors.divider)
            .scaleEffect(isFilled ? 1.0 : 0.85)
    }
}
