import SwiftUI
import SwiftData

struct HydrationQuickView: View {
    @Bindable var viewModel: HydrationViewModel
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        FGCard {
            VStack(spacing: FGSpacing.md) {
                // Header
                HStack {
                    HStack(spacing: FGSpacing.sm) {
                        Image(systemName: "drop.fill")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(FGColors.hydrationBlue)

                        Text("Water Today")
                            .font(FGTypography.headline)
                            .foregroundStyle(FGColors.textPrimary)
                    }

                    Spacer()

                    Text("Goal: \(viewModel.goal) cups")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }

                // Glass counter (hero)
                FGGlassCounter(
                    current: viewModel.todayGlasses,
                    goal: viewModel.goal,
                    onAdd: { viewModel.addGlass(context: modelContext) },
                    onRemove: { viewModel.removeGlass(context: modelContext) }
                )

                // Big count + encouragement
                VStack(spacing: FGSpacing.xs) {
                    Text("\(viewModel.todayGlasses) of \(viewModel.goal) cups")
                        .font(FGTypography.title)
                        .foregroundStyle(FGColors.hydrationBlue)
                        .fontWeight(.bold)

                    Text(hydrationMessage)
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    private var hydrationMessage: String {
        let pct = Double(viewModel.todayGlasses) / Double(max(viewModel.goal, 1))
        if viewModel.todayGlasses >= viewModel.goal {
            return "Great job staying hydrated today! 🎉"
        } else if pct >= 0.5 {
            return "You're halfway there — keep sipping!"
        } else if viewModel.todayGlasses == 0 {
            return "Tap + to log your first glass."
        } else {
            return "Every sip counts — you're doing well!"
        }
    }
}
