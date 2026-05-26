import SwiftUI

struct LogMealSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: FGSpacing.xl) {
                Spacer()

                Text("How would you like to log?")
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)

                VStack(spacing: FGSpacing.md) {
                    NavigationLink {
                        ManualMealView(onSave: { dismiss() })
                    } label: {
                        LogOptionCard(
                            icon: "hand.tap.fill",
                            title: "Choose Foods",
                            subtitle: "Pick from common foods",
                            color: FGColors.accent
                        )
                    }

                    NavigationLink {
                        PhotoCaptureView(onSave: { dismiss() })
                    } label: {
                        LogOptionCard(
                            icon: "camera.fill",
                            title: "Take a Photo",
                            subtitle: "Snap a picture of your meal",
                            color: FGColors.hydrationBlue
                        )
                    }
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                Spacer()
            }
            .background(FGColors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)
                }
            }
        }
    }
}

private struct LogOptionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color

    var body: some View {
        HStack(spacing: FGSpacing.lg) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 56, height: 56)

                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(color)
            }

            VStack(alignment: .leading, spacing: FGSpacing.xs) {
                Text(title)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(FGColors.textPrimary)

                Text(subtitle)
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(FGColors.textSecondary)
        }
        .padding(FGSpacing.lg)
        .background(FGColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))
        .fgCardShadow()
    }
}
