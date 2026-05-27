import Foundation

struct NutritionScoringService {
    func calculate(meals: [MealEntry]) -> NutritionScore {
        guard !meals.isEmpty else { return .empty }

        let varietyScore = calculateVariety(meals: meals)
        let proteinScore = calculateProtein(meals: meals)
        let produceScore = calculateProduce(meals: meals)
        let regularityScore = calculateRegularity(meals: meals)
        let total = varietyScore + proteinScore + produceScore + regularityScore
        let feedback = generateFeedback(total: total, protein: proteinScore, produce: produceScore, variety: varietyScore)

        return NutritionScore(
            total: total,
            varietyScore: varietyScore,
            proteinScore: proteinScore,
            produceScore: produceScore,
            regularityScore: regularityScore,
            feedback: feedback
        )
    }

    private func calculateVariety(meals: [MealEntry]) -> Int {
        let allCategories = Set(meals.flatMap { $0.foods.map(\.category) })
        let categoryCount = allCategories.count
        let maxCategories = FoodCategory.allCases.count
        let ratio = Double(categoryCount) / Double(maxCategories)
        return Int(ratio * 40)
    }

    private func calculateProtein(meals: [MealEntry]) -> Int {
        let hasProtein = meals.contains { meal in
            meal.foods.contains { $0.category == .protein }
        }
        if !hasProtein { return 0 }

        let proteinMeals = meals.filter { meal in
            meal.foods.contains { $0.category == .protein }
        }
        let ratio = Double(proteinMeals.count) / Double(max(meals.count, 1))
        return Int(ratio * 25)
    }

    private func calculateProduce(meals: [MealEntry]) -> Int {
        let hasFruit = meals.contains { meal in
            meal.foods.contains { $0.category == .fruit }
        }
        let hasVegetable = meals.contains { meal in
            meal.foods.contains { $0.category == .vegetable }
        }

        var score = 0
        if hasFruit { score += 10 }
        if hasVegetable { score += 10 }
        return score
    }

    private func calculateRegularity(meals: [MealEntry]) -> Int {
        let mealTypes = Set(meals.map(\.mealType))
        let expectedMeals: Set<MealType> = [.breakfast, .lunch, .dinner]
        let covered = mealTypes.intersection(expectedMeals).count
        let ratio = Double(covered) / 3.0
        return Int(ratio * 15)
    }

    private func generateFeedback(total: Int, protein: Int, produce: Int, variety: Int) -> String {
        if total >= 80 { return "You're having a wonderful day! 🌟" }
        if total >= 60 { return "You're doing well! A little more will help." }
        if total >= 40 { return "Good start! Try adding a fruit or vegetable." }
        return "Let's get some goodness in today. You've got this! 💚"
    }
}
