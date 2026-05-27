import SwiftUI

struct GreetingHeader: View {
    let greeting: String
    let streak: Int

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: FGSpacing.xs) {
                    Text(greeting)
                        .font(FGTypography.title)
                        .foregroundStyle(FGColors.textPrimary)

                    Text("You're doing great today. 👋")
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)
                }

                Spacer()

                if streak > 0 {
                    FGStreakBadge(count: streak, label: "day streak")
                }
            }
        }
        .padding(.horizontal, FGSpacing.screenPadding)
        .padding(.top, FGSpacing.md)
    }
}
