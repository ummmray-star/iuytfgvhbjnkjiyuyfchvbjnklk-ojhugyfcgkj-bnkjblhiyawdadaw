import SwiftUI
import SwiftData

@Observable
final class MealLogViewModel {
    var showingLogSheet = false
    var showingPhotoCapture = false
    var selectedMealType: MealType = .suggested()

    func logMeal(_ meal: MealEntry, context: ModelContext) {
        context.insert(meal)
        HapticService.success()
    }

    func deleteMeal(_ meal: MealEntry, context: ModelContext) {
        context.delete(meal)
    }

    func toggleFavorite(_ meal: MealEntry) {
        meal.isFavorite.toggle()
        HapticService.lightTap()
    }

    func todayMeals(from meals: [MealEntry]) -> [MealEntry] {
        meals
            .filter { Calendar.current.isDateInToday($0.timestamp) }
            .sorted { $0.timestamp > $1.timestamp }
    }

    func weekMeals(from meals: [MealEntry]) -> [MealEntry] {
        let weekAgo = Date.now.daysAgo(7)
        return meals
            .filter { $0.timestamp > weekAgo }
            .sorted { $0.timestamp > $1.timestamp }
    }

    func favoriteMeals(from meals: [MealEntry]) -> [MealEntry] {
        meals.filter(\.isFavorite).sorted { $0.timestamp > $1.timestamp }
    }
}
