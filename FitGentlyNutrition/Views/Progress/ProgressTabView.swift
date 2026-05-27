import SwiftUI
import SwiftData

struct ProgressTabView: View {
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var meals: [MealEntry]
    @Query(sort: \HydrationEntry.timestamp, order: .reverse) private var hydrationEntries: [HydrationEntry]
    @State private var viewModel = ProgressViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                // Steps card
                StepsProgressCard(steps: viewModel.stepsToday, goal: 7000)
                    .padding(.horizontal, FGSpacing.screenPadding)

                // Weight + Water row
                HStack(spacing: FGSpacing.md) {
                    SimpleStatCard(
                        icon: "scalemass.fill",
                        title: "Weight",
                        value: viewModel.weightDisplay,
                        color: FGColors.accent
                    )
                    SimpleStatCard(
                        icon: "drop.fill",
                        title: "Water",
                        value: viewModel.waterDisplay,
                        color: FGColors.hydrationBlue
                    )
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                // Encouraging message
                EncouragementCard()
                    .padding(.horizontal, FGSpacing.screenPadding)
            }
            .padding(.top, FGSpacing.md)
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationTitle("Progress")
        .onAppear { viewModel.refresh(meals: meals, hydrationEntries: hydrationEntries) }
    }
}

// MARK: - StepsProgressCard

private struct StepsProgressCard: View {
    let steps: Int
    let goal: Int

    private var progress: Double { min(Double(steps) / Double(goal), 1.0) }
    private var pct: Int { Int(progress * 100) }

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.md) {
                HStack {
                    HStack(spacing: FGSpacing.sm) {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(FGColors.accent)
                        Text("Steps Today")
                            .font(FGTypography.headline)
                            .foregroundStyle(FGColors.textPrimary)
                    }
                    Spacer()
                    Text("Goal: \(goal.formatted())")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }

                Text(steps == 0 ? "—" : steps.formatted())
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(FGColors.textPrimary)

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(FGColors.surfaceSecondary)
                            .frame(height: 12)
                        RoundedRectangle(cornerRadius: 6)
                            .fill(progress >= 1.0 ? Color.green : FGColors.accent)
                            .frame(width: geo.size.width * progress, height: 12)
                    }
                }
                .frame(height: 12)

                Text(stepsMessage)
                    .font(FGTypography.caption)
                    .foregroundStyle(FGColors.textSecondary)
            }
        }
    }

    private var stepsMessage: String {
        if steps == 0 { return "Connect Apple Health to see your steps." }
        if steps >= goal { return "Goal reached! Wonderful work today. 🌟" }
        let remaining = goal - steps
        return "\(remaining.formatted()) more steps to reach your goal."
    }
}

// MARK: - SimpleStatCard

private struct SimpleStatCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.sm) {
                HStack(spacing: FGSpacing.sm) {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(color)
                    Text(title)
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }

                Text(value)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(FGColors.textPrimary)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - EncouragementCard

private struct EncouragementCard: View {
    var body: some View {
        FGCard {
            HStack(spacing: FGSpacing.md) {
                Text("💚")
                    .font(.system(size: 36))

                VStack(alignment: .leading, spacing: FGSpacing.xs) {
                    Text("You're doing wonderfully!")
                        .font(FGTypography.bodyBold)
                        .foregroundStyle(FGColors.textPrimary)

                    Text("Small steps, big changes. Every healthy choice adds up. Keep it up!")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
