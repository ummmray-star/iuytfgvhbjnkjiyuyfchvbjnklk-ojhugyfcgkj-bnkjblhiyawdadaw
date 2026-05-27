import SwiftUI
import SwiftData

@Observable
final class ProgressViewModel {
    var weeklyScores: [(date: Date, score: Int)] = []
    var weeklyHydration: [(date: Date, glasses: Int)] = []
    var mealStreak: Int = 0
    var proteinStreak: Int = 0
    var averageScore: Int = 0
    var totalMealsThisWeek: Int = 0

    // Simple display values — HealthKit integration adds real data in a future update
    var stepsToday: Int = 0
    var weightDisplay: String = "—"
    var waterDisplay: String = "0 cups"

    func refresh(meals: [MealEntry], hydrationEntries: [HydrationEntry]) {
        let today = Date.now.startOfDay
        let scoringService = NutritionScoringService()

        var scores: [(Date, Int)] = []
        var hydration: [(Date, Int)] = []

        for dayOffset in (0..<7).reversed() {
            let date = today.daysAgo(dayOffset)
            let dayMeals = meals.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
            let dayScore = scoringService.calculate(meals: dayMeals)
            scores.append((date, dayScore.total))

            let dayGlasses = hydrationEntries
                .filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
                .reduce(0) { $0 + $1.glasses }
            hydration.append((date, dayGlasses))
        }

        weeklyScores = scores
        weeklyHydration = hydration
        averageScore = scores.isEmpty ? 0 : scores.map(\.1).reduce(0, +) / scores.count

        let weekMeals = meals.filter { $0.timestamp > today.daysAgo(7) }
        totalMealsThisWeek = weekMeals.count

        mealStreak = calculateStreak(meals: meals, check: { _ in true })
        proteinStreak = calculateStreak(meals: meals, check: { meal in
            meal.foods.contains { $0.category == .protein }
        })

        let todayGlasses = hydrationEntries
            .filter { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }
            .reduce(0) { $0 + $1.glasses }
        waterDisplay = "\(todayGlasses) cups"
    }

    private func calculateStreak(meals: [MealEntry], check: (MealEntry) -> Bool) -> Int {
        var count = 0
        var date = Date.now.startOfDay

        for _ in 0..<365 {
            let dayMeals = meals.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
            if dayMeals.contains(where: check) {
                count += 1
                date = date.daysAgo(1)
            } else {
                break
            }
        }
        return count
    }
}
