import SwiftUI

struct FGInsightCard: View {
    let insight: AIInsight

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            Circle()
                .fill(iconColor.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: iconName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(iconColor)
                }

            Text(insight.message)
                .font(FGTypography.body)
                .foregroundStyle(FGColors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)
        }
        .padding(FGSpacing.lg)
        .background(FGColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))
        .fgCardShadow()
    }

    private var iconName: String {
        switch insight.category {
        case .encouragement: return "star.fill"
        case .suggestion: return "lightbulb.fill"
        case .alert: return "bell.fill"
        }
    }

    private var iconColor: Color {
        switch insight.category {
        case .encouragement: return FGColors.warmOrange
        case .suggestion: return FGColors.accent
        case .alert: return FGColors.hydrationBlue
        }
    }
}
