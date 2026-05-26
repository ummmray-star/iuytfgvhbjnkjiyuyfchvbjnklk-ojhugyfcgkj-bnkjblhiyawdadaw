import SwiftUI

struct FGSectionHeader: View {
    let title: String
    let action: (() -> Void)?
    let actionLabel: String?

    init(_ title: String, actionLabel: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.actionLabel = actionLabel
        self.action = action
    }

    var body: some View {
        HStack {
            Text(title)
                .font(FGTypography.headline)
                .foregroundStyle(FGColors.textPrimary)

            Spacer()

            if let action, let actionLabel {
                Button(action: action) {
                    Text(actionLabel)
                        .font(FGTypography.captionBold)
                        .foregroundStyle(FGColors.accentDark)
                }
                .accessibleTapTarget()
            }
        }
        .padding(.horizontal, FGSpacing.screenPadding)
    }
}
