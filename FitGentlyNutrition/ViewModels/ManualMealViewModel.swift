import SwiftUI
import SwiftData

@Observable
final class ManualMealViewModel {
    var selectedFoods: [CommonFood] = []
    var selectedPortions: [UUID: Portion] = [:]
    var mealType: MealType = .suggested()

    var canSave: Bool {
        !selectedFoods.isEmpty
    }

    func toggleFood(_ food: CommonFood) {
        if let index = selectedFoods.firstIndex(where: { $0.name == food.name }) {
            selectedFoods.remove(at: index)
            selectedPortions.removeValue(forKey: food.id)
        } else {
            selectedFoods.append(food)
            selectedPortions[food.id] = .medium
        }
        HapticService.selection()
    }

    func setPortion(_ portion: Portion, for food: CommonFood) {
        selectedPortions[food.id] = portion
    }

    func isSelected(_ food: CommonFood) -> Bool {
        selectedFoods.contains(where: { $0.name == food.name })
    }

    func buildMealEntry() -> MealEntry {
        let foodItems = selectedFoods.map { food in
            FoodItem(
                name: food.name,
                category: food.category,
                portion: selectedPortions[food.id] ?? .medium,
                iconName: food.iconName
            )
        }
        return MealEntry(mealType: mealType, source: .manual, foods: foodItems)
    }

    func reset() {
        selectedFoods = []
        selectedPortions = [:]
        mealType = .suggested()
    }
}
