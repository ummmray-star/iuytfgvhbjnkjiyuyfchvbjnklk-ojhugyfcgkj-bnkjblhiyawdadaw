import SwiftUI

enum FGButtonStyle {
    case primary
    case secondary
    case outline
}

struct FGButton: View {
    let title: String
    let icon: String?
    let style: FGButtonStyle
    let action: () -> Void

    init(_ title: String, icon: String? = nil, style: FGButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: FGSpacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                }
                Text(title)
                    .font(FGTypography.bodyBold)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: FGSpacing.touchTarget)
            .padding(.horizontal, FGSpacing.lg)
            .padding(.vertical, FGSpacing.md)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous))
            .overlay {
                if style == .outline {
                    RoundedRectangle(cornerRadius: FGSpacing.buttonRadius, style: .continuous)
                        .strokeBorder(FGColors.accent, lineWidth: 2)
                }
            }
        }
        .accessibleTapTarget()
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return FGColors.accent
        case .secondary: return FGColors.surfaceSecondary
        case .outline: return .clear
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: return FGColors.textOnAccent
        case .secondary: return FGColors.textPrimary
        case .outline: return FGColors.accentDark
        }
    }
}
