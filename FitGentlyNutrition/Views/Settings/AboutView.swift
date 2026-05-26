import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.xl) {
                Spacer(minLength: FGSpacing.xl)

                VStack(spacing: FGSpacing.md) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 56, weight: .light))
                        .foregroundStyle(FGColors.accent)

                    Text("FitGently Nutrition")
                        .font(FGTypography.title)
                        .foregroundStyle(FGColors.textPrimary)

                    Text("Version 1.0")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }

                FGCard {
                    VStack(spacing: FGSpacing.md) {
                        Text("A gentle daily nutrition companion designed for healthy aging.")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                            .multilineTextAlignment(.center)

                        Text("Built with care for simplicity, accessibility, and emotional comfort.")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                Spacer()
            }
        }
        .background(FGColors.background)
        .navigationTitle("About")
    }
}
