import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var meals: [MealEntry]
    @Query(sort: \HydrationEntry.timestamp, order: .reverse) private var hydrationEntries: [HydrationEntry]

    @State private var viewModel = HomeViewModel()
    @State private var hydrationVM = HydrationViewModel()
    @State private var showingAddMeal = false

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                GreetingHeader(
                    greeting: viewModel.greeting,
                    streak: viewModel.streak
                )

                TodaysHealthView(
                    score: viewModel.nourishmentScore,
                    todayGlasses: viewModel.todayGlasses,
                    hydrationGoal: hydrationVM.goal,
                    mealCount: todayMealCount
                )
                .padding(.horizontal, FGSpacing.screenPadding)

                HydrationQuickView(viewModel: hydrationVM)
                    .padding(.horizontal, FGSpacing.screenPadding)

                WhatNextCard(
                    score: viewModel.nourishmentScore,
                    todayGlasses: viewModel.todayGlasses,
                    hydrationGoal: hydrationVM.goal,
                    mealCount: todayMealCount,
                    onAddMeal: { showingAddMeal = true }
                )
                .padding(.horizontal, FGSpacing.screenPadding)
            }
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { refresh() }
        .onChange(of: meals.count) { refresh() }
        .onChange(of: hydrationEntries.count) { refresh() }
        .sheet(isPresented: $showingAddMeal) {
            LogMealSheet()
        }
    }

    private var todayMealCount: Int {
        meals.filter { Calendar.current.isDateInToday($0.timestamp) }.count
    }

    private func refresh() {
        viewModel.userName = appState.userName
        viewModel.hydrationGoal = hydrationVM.goal
        viewModel.refresh(meals: meals, hydrationEntries: hydrationEntries, allMeals: meals)
        hydrationVM.refresh(entries: hydrationEntries)
    }
}
