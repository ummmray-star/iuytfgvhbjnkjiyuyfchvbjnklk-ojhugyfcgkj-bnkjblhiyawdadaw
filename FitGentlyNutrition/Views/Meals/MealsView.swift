import SwiftUI
import SwiftData

struct MealsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var meals: [MealEntry]
    @State private var viewModel = MealLogViewModel()
    @State private var selectedFilter: MealFilter = .today

    enum MealFilter: String, CaseIterable {
        case today = "Today"
        case week = "This Week"
        case favorites = "Favorites"
    }

    var body: some View {
        VStack(spacing: 0) {
            Picker("Filter", selection: $selectedFilter) {
                ForEach(MealFilter.allCases, id: \.self) { filter in
                    Text(filter.rawValue).tag(filter)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, FGSpacing.screenPadding)
            .padding(.vertical, FGSpacing.md)

            if filteredMeals.isEmpty {
                Spacer()
                FGEmptyState(
                    icon: "fork.knife",
                    title: emptyTitle,
                    message: emptyMessage,
                    actionTitle: "Log a Meal",
                    action: { viewModel.showingLogSheet = true }
                )
                Spacer()
            } else {
                List {
                    ForEach(filteredMeals) { meal in
                        NavigationLink(destination: MealDetailView(meal: meal)) {
                            MealLogRow(meal: meal)
                        }
                        .listRowBackground(FGColors.surface)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.deleteMeal(meal, context: modelContext)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                viewModel.toggleFavorite(meal)
                            } label: {
                                Label(
                                    meal.isFavorite ? "Unfavorite" : "Favorite",
                                    systemImage: meal.isFavorite ? "heart.slash" : "heart"
                                )
                            }
                            .tint(FGColors.warmOrange)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .background(FGColors.background)
        .navigationTitle("Meals")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { viewModel.showingLogSheet = true } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(FGColors.accent)
                }
                .accessibilityLabel("Log a meal")
            }
        }
        .sheet(isPresented: $viewModel.showingLogSheet) {
            LogMealSheet()
        }
    }

    private var filteredMeals: [MealEntry] {
        switch selectedFilter {
        case .today: return viewModel.todayMeals(from: meals)
        case .week: return viewModel.weekMeals(from: meals)
        case .favorites: return viewModel.favoriteMeals(from: meals)
        }
    }

    private var emptyTitle: String {
        switch selectedFilter {
        case .today: return "No meals today"
        case .week: return "No meals this week"
        case .favorites: return "No favorites yet"
        }
    }

    private var emptyMessage: String {
        switch selectedFilter {
        case .today: return "Log your first meal to start tracking your nourishment."
        case .week: return "Start logging meals to see your weekly nutrition."
        case .favorites: return "Swipe right on a meal to save it as a favorite."
        }
    }
}
