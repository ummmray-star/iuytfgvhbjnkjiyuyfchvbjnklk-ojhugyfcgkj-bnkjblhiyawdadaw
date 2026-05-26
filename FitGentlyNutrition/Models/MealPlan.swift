import Foundation

struct MealPlan: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let mealType: String
    let ingredients: [String]
    let steps: [String]
    let prepTimeMinutes: Int
    let tags: [String]

    init(title: String, description: String, mealType: String, ingredients: [String], steps: [String], prepTimeMinutes: Int, tags: [String] = []) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.mealType = mealType
        self.ingredients = ingredients
        self.steps = steps
        self.prepTimeMinutes = prepTimeMinutes
        self.tags = tags
    }
}
