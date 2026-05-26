import SwiftUI

struct FGEmptyState: View {
    let icon: String
    let title: String
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?

    init(icon: String, title: String, message: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        VStack(spacing: FGSpacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 56, weight: .light))
                .foregroundStyle(FGColors.accent.opacity(0.6))

            VStack(spacing: FGSpacing.sm) {
                Text(title)
                    .font(FGTypography.headline)
                    .foregroundStyle(FGColors.textPrimary)

                Text(message)
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let actionTitle, let action {
                FGButton(actionTitle, icon: "plus", action: action)
                    .frame(maxWidth: 260)
            }
        }
        .padding(FGSpacing.xxl)
    }
}
