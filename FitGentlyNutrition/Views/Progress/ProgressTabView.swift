import SwiftUI
import SwiftData

struct ProgressTabView: View {
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var meals: [MealEntry]
    @Query(sort: \HydrationEntry.timestamp, order: .reverse) private var hydrationEntries: [HydrationEntry]
    @State private var viewModel = ProgressViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                FGSectionHeader("This Week")

                WeeklyTrendCard(scores: viewModel.weeklyScores)
                    .padding(.horizontal, FGSpacing.screenPadding)

                HStack(spacing: FGSpacing.md) {
                    StreakCard(title: "Meal Streak", count: viewModel.mealStreak, icon: "fork.knife", color: FGColors.accent)
                    StreakCard(title: "Protein", count: viewModel.proteinStreak, icon: "fish.fill", color: FGColors.warmOrange)
                }
                .padding(.horizontal, FGSpacing.screenPadding)

                HydrationHistoryCard(hydration: viewModel.weeklyHydration, goal: 8)
                    .padding(.horizontal, FGSpacing.screenPadding)

                HabitSummaryCard(
                    averageScore: viewModel.averageScore,
                    totalMeals: viewModel.totalMealsThisWeek
                )
                .padding(.horizontal, FGSpacing.screenPadding)
            }
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationTitle("Progress")
        .onAppear { viewModel.refresh(meals: meals, hydrationEntries: hydrationEntries) }
    }
}
