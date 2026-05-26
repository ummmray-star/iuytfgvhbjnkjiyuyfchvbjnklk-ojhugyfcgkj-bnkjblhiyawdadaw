import SwiftUI
import SwiftData

enum PreviewData {
    static let sampleMeals: [MealEntry] = {
        let breakfast = MealEntry(mealType: .breakfast, source: .manual, foods: [
            FoodItem(name: "Eggs", category: .protein, portion: .medium, iconName: "oval.fill"),
            FoodItem(name: "Toast", category: .grain, portion: .medium, iconName: "rectangle.fill"),
        ])

        let lunch = MealEntry(mealType: .lunch, source: .manual, foods: [
            FoodItem(name: "Chicken", category: .protein, portion: .large, iconName: "fish.fill"),
            FoodItem(name: "Rice", category: .grain, portion: .medium, iconName: "leaf.fill"),
            FoodItem(name: "Broccoli", category: .vegetable, portion: .medium, iconName: "tree.fill"),
        ])

        let dinner = MealEntry(mealType: .dinner, source: .photo, foods: [
            FoodItem(name: "Fish", category: .protein, portion: .medium, iconName: "fish.fill"),
            FoodItem(name: "Salad", category: .vegetable, portion: .large, iconName: "leaf.fill"),
        ], aiFeedback: "Great balance of protein and vegetables!")

        return [breakfast, lunch, dinner]
    }()

    static let sampleInsights: [AIInsight] = [
        AIInsight(message: "You've had protein with every meal today. Keep it up!", category: .encouragement, priority: 1),
        AIInsight(message: "Your hydration is a little low. Try a glass of water.", category: .suggestion, priority: 2),
        AIInsight(message: "Adding a fruit or vegetable would round out your day.", category: .suggestion, priority: 3),
    ]

    static let sampleScore = NutritionScore(
        total: 72,
        varietyScore: 28,
        proteinScore: 22,
        produceScore: 12,
        regularityScore: 10,
        feedback: "Great day so far! A vegetable would make it even better."
    )

    @MainActor
    static var previewContainer: ModelContainer {
        let schema = Schema([MealEntry.self, FoodItem.self, HydrationEntry.self, DailySnapshot.self, AIInsight.self, UserProfile.self, CaregiverLink.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [config])
        return container
    }
}
