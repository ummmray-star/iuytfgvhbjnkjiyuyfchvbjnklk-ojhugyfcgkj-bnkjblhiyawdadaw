import SwiftUI
import SwiftData

struct HydrationQuickView: View {
    @Bindable var viewModel: HydrationViewModel
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        FGCard {
            VStack(spacing: FGSpacing.md) {
                HStack {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(FGColors.hydrationBlue)

                    Text("Hydration")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)

                    Spacer()

                    Text(viewModel.statusMessage)
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }

                FGProgressBar(
                    progress: viewModel.progress,
                    color: FGColors.hydrationBlue,
                    height: 10
                )

                FGGlassCounter(
                    current: viewModel.todayGlasses,
                    goal: viewModel.goal,
                    onAdd: { viewModel.addGlass(context: modelContext) },
                    onRemove: { viewModel.removeGlass(context: modelContext) }
                )
            }
        }
    }
}
