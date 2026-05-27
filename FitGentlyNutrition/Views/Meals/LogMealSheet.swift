import SwiftUI

struct LogMealSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: FGSpacing.lg) {
                    // Header
                    VStack(spacing: FGSpacing.sm) {
                        Text("Add a Meal")
                            .font(FGTypography.title)
                            .foregroundStyle(FGColors.textPrimary)

                        Text("How would you like to log it?")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textSecondary)
                    }

                    // Options
                    VStack(spacing: FGSpacing.md) {
                        NavigationLink {
                            ManualMealView(onSave: { dismiss() })
                        } label: {
                            LogOptionCard(
                                icon: "hand.tap.fill",
                                title: "Choose Foods",
                                subtitle: "Tap to pick what you ate",
                                color: FGColors.accent
                            )
                        }
                        .buttonStyle(.plain)

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
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, FGSpacing.screenPadding)
                }

                Spacer()

                // Cancel
                Button("Cancel") { dismiss() }
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: FGSpacing.touchTarget)
                    .padding(.bottom, FGSpacing.lg)
            }
            .background(FGColors.background)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - LogOptionCard

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
                    .frame(width: 64, height: 64)
                Image(systemName: icon)
                    .font(.system(size: 28, weight: .semibold))
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
                .foregroundStyle(FGColors.textSecondary.opacity(0.5))
        }
        .padding(FGSpacing.lg)
        .frame(minHeight: 90)
        .background(FGColors.surface)
        .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 3)
    }
}
