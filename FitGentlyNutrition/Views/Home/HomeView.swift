import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var meals: [MealEntry]
    @Query(sort: \HydrationEntry.timestamp, order: .reverse) private var hydrationEntries: [HydrationEntry]

    @State private var viewModel = HomeViewModel()
    @State private var hydrationVM = HydrationViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                GreetingHeader(
                    greeting: viewModel.greeting,
                    streak: viewModel.streak
                )

                NourishmentScoreView(score: viewModel.nourishmentScore)
                    .padding(.horizontal, FGSpacing.screenPadding)

                HydrationQuickView(viewModel: hydrationVM)
                    .padding(.horizontal, FGSpacing.screenPadding)

                if !viewModel.insights.isEmpty {
                    InsightCarousel(insights: viewModel.insights)
                }
            }
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { refresh() }
        .onChange(of: meals.count) { refresh() }
        .onChange(of: hydrationEntries.count) { refresh() }
    }

    private func refresh() {
        viewModel.userName = appState.userName
        viewModel.hydrationGoal = hydrationVM.goal
        viewModel.refresh(meals: meals, hydrationEntries: hydrationEntries, allMeals: meals)
        hydrationVM.refresh(entries: hydrationEntries)
    }
}
