import Foundation
import SwiftData

struct InsightEngine {
    func generateInsights(meals: [MealEntry], hydrationEntries: [HydrationEntry], hydrationGoal: Int) -> [AIInsight] {
        var insights: [AIInsight] = []

        let today = Date.now.startOfDay
        let todayMeals = meals.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }
        let todayGlasses = hydrationEntries
            .filter { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }
            .reduce(0) { $0 + $1.glasses }

        if todayGlasses < hydrationGoal / 2 {
            insights.append(AIInsight(
                message: "Your hydration is a little low today. A small glass of water can help with energy.",
                category: .suggestion,
                priority: 2
            ))
        }

        let hasProteinToday = todayMeals.contains { meal in
            meal.foods.contains { $0.category == .protein }
        }
        if !hasProteinToday && !todayMeals.isEmpty {
            insights.append(AIInsight(
                message: "Try adding some protein to your next meal. It helps maintain strength.",
                category: .suggestion,
                priority: 2
            ))
        }

        let weekMeals = meals.filter { $0.timestamp > today.daysAgo(7) }
        let daysWithMeals = Set(weekMeals.map { Calendar.current.startOfDay(for: $0.timestamp) })
        if daysWithMeals.count >= 5 {
            insights.append(AIInsight(
                message: "You've been eating consistently this week. Keep it up!",
                category: .encouragement,
                priority: 3
            ))
        }

        let breakfastDays = Set(weekMeals.filter { $0.mealType == .breakfast }.map { Calendar.current.startOfDay(for: $0.timestamp) })
        if breakfastDays.count < 3 && weekMeals.count > 3 {
            insights.append(AIInsight(
                message: "Breakfast has been light this week. Even something small in the morning helps energy.",
                category: .suggestion,
                priority: 3
            ))
        }

        if todayGlasses >= hydrationGoal {
            insights.append(AIInsight(
                message: "Great hydration today! Your body thanks you.",
                category: .encouragement,
                priority: 4
            ))
        }

        return insights.sorted { $0.priority < $1.priority }
    }
}
