import Foundation
import SwiftData

@Model
final class DailySnapshot {
    var id: UUID
    var date: Date
    var nourishmentScore: Int
    var totalGlasses: Int
    var mealsLogged: Int
    var hasProtein: Bool
    var hasFruitOrVeg: Bool
    var mealTypesRaw: String

    var mealTypes: [MealType] {
        mealTypesRaw.split(separator: ",").compactMap { MealType(rawValue: String($0)) }
    }

    init(date: Date, nourishmentScore: Int = 0, totalGlasses: Int = 0, mealsLogged: Int = 0, hasProtein: Bool = false, hasFruitOrVeg: Bool = false, mealTypes: [MealType] = []) {
        self.id = UUID()
        self.date = date.startOfDay
        self.nourishmentScore = nourishmentScore
        self.totalGlasses = totalGlasses
        self.mealsLogged = mealsLogged
        self.hasProtein = hasProtein
        self.hasFruitOrVeg = hasFruitOrVeg
        self.mealTypesRaw = mealTypes.map(\.rawValue).joined(separator: ",")
    }
}
