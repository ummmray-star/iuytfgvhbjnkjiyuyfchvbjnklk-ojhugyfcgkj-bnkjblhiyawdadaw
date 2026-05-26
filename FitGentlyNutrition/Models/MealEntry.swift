import Foundation
import SwiftData

enum MealType: String, Codable, CaseIterable, Identifiable {
    case breakfast, lunch, dinner, snack

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        case .snack: return "Snack"
        }
    }

    var iconName: String {
        switch self {
        case .breakfast: return "sun.horizon.fill"
        case .lunch: return "sun.max.fill"
        case .dinner: return "moon.fill"
        case .snack: return "leaf.fill"
        }
    }

    static func suggested(for date: Date = .now) -> MealType {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 5..<11: return .breakfast
        case 11..<15: return .lunch
        case 15..<17: return .snack
        default: return .dinner
        }
    }
}

enum EntrySource: String, Codable {
    case manual, photo
}

@Model
final class MealEntry {
    var id: UUID
    var timestamp: Date
    var mealTypeRaw: String
    var sourceRaw: String
    @Relationship(deleteRule: .cascade) var foods: [FoodItem]
    var photoData: Data?
    var aiFeedback: String?
    var isFavorite: Bool

    var mealType: MealType {
        get { MealType(rawValue: mealTypeRaw) ?? .snack }
        set { mealTypeRaw = newValue.rawValue }
    }

    var source: EntrySource {
        get { EntrySource(rawValue: sourceRaw) ?? .manual }
        set { sourceRaw = newValue.rawValue }
    }

    var foodSummary: String {
        foods.map(\.name).joined(separator: ", ")
    }

    var categories: Set<FoodCategory> {
        Set(foods.map(\.category))
    }

    init(mealType: MealType, source: EntrySource = .manual, foods: [FoodItem] = [], photoData: Data? = nil, aiFeedback: String? = nil) {
        self.id = UUID()
        self.timestamp = .now
        self.mealTypeRaw = mealType.rawValue
        self.sourceRaw = source.rawValue
        self.foods = foods
        self.photoData = photoData
        self.aiFeedback = aiFeedback
        self.isFavorite = false
    }
}
