import Foundation
import SwiftData

enum Portion: String, Codable, CaseIterable, Identifiable {
    case small, medium, large

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        }
    }

    var emoji: String {
        switch self {
        case .small: return "S"
        case .medium: return "M"
        case .large: return "L"
        }
    }
}

@Model
final class FoodItem {
    var id: UUID
    var name: String
    var categoryRaw: String
    var portionRaw: String
    var iconName: String
    var meal: MealEntry?

    var category: FoodCategory {
        get { FoodCategory(rawValue: categoryRaw) ?? .other }
        set { categoryRaw = newValue.rawValue }
    }

    var portion: Portion {
        get { Portion(rawValue: portionRaw) ?? .medium }
        set { portionRaw = newValue.rawValue }
    }

    init(name: String, category: FoodCategory, portion: Portion = .medium, iconName: String = "fork.knife") {
        self.id = UUID()
        self.name = name
        self.categoryRaw = category.rawValue
        self.portionRaw = portion.rawValue
        self.iconName = iconName
    }
}
