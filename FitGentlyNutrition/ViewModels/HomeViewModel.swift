import SwiftUI
import SwiftData

@Observable
final class HomeViewModel {
    var nourishmentScore: NutritionScore = .empty
    var todayGlasses: Int = 0
    var hydrationGoal: Int = 8
    var streak: Int = 0
    var insights: [AIInsight] = []
    var greeting: String = ""
    var userName: String = "Friend"

    private let scoringService = NutritionScoringService()
    private let insightEngine = InsightEngine()

    func refresh(meals: [MealEntry], hydrationEntries: [HydrationEntry], allMeals: [MealEntry]) {
        let today = Date.now.startOfDay
        let todayMeals = meals.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }

        nourishmentScore = scoringService.calculate(meals: todayMeals)

        todayGlasses = hydrationEntries
            .filter { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }
            .reduce(0) { $0 + $1.glasses }

        streak = calculateStreak(meals: allMeals)
        greeting = "\(Date.now.timeOfDayGreeting), \(userName)."
        insights = insightEngine.generateInsights(
            meals: allMeals,
            hydrationEntries: hydrationEntries,
            hydrationGoal: hydrationGoal
        )
    }

    private func calculateStreak(meals: [MealEntry]) -> Int {
        var streakCount = 0
        var checkDate = Date.now.startOfDay

        for _ in 0..<365 {
            let hasMeal = meals.contains { Calendar.current.isDate($0.timestamp, inSameDayAs: checkDate) }
            if hasMeal {
                streakCount += 1
                checkDate = checkDate.daysAgo(1)
            } else {
                break
            }
        }
        return streakCount
    }
}
