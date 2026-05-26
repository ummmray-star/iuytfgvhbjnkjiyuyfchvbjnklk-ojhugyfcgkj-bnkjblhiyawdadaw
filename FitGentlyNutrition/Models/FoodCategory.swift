import SwiftUI

enum FoodCategory: String, Codable, CaseIterable, Identifiable {
    case protein, grain, vegetable, fruit, dairy, liquid, other

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .protein: return "Protein"
        case .grain: return "Grains"
        case .vegetable: return "Vegetables"
        case .fruit: return "Fruit"
        case .dairy: return "Dairy"
        case .liquid: return "Drinks"
        case .other: return "Other"
        }
    }

    var iconName: String {
        switch self {
        case .protein: return "fish.fill"
        case .grain: return "leaf.fill"
        case .vegetable: return "carrot.fill"
        case .fruit: return "apple.logo"
        case .dairy: return "cup.and.saucer.fill"
        case .liquid: return "drop.fill"
        case .other: return "fork.knife"
        }
    }

    var accentColor: Color {
        switch self {
        case .protein: return Color(hex: "E8A87C")
        case .grain: return Color(hex: "D4B896")
        case .vegetable: return Color(hex: "A8D86E")
        case .fruit: return Color(hex: "F2C94C")
        case .dairy: return Color(hex: "7EC8E3")
        case .liquid: return Color(hex: "7EC8E3")
        case .other: return Color(hex: "C4B5A5")
        }
    }
}

struct CommonFood: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: FoodCategory
    let iconName: String

    static let all: [CommonFood] = [
        CommonFood(name: "Eggs", category: .protein, iconName: "oval.fill"),
        CommonFood(name: "Chicken", category: .protein, iconName: "fish.fill"),
        CommonFood(name: "Fish", category: .protein, iconName: "fish.fill"),
        CommonFood(name: "Beans", category: .protein, iconName: "leaf.fill"),
        CommonFood(name: "Rice", category: .grain, iconName: "leaf.fill"),
        CommonFood(name: "Bread", category: .grain, iconName: "rectangle.fill"),
        CommonFood(name: "Oatmeal", category: .grain, iconName: "bowl.fill"),
        CommonFood(name: "Pasta", category: .grain, iconName: "leaf.fill"),
        CommonFood(name: "Salad", category: .vegetable, iconName: "leaf.fill"),
        CommonFood(name: "Broccoli", category: .vegetable, iconName: "tree.fill"),
        CommonFood(name: "Carrots", category: .vegetable, iconName: "carrot.fill"),
        CommonFood(name: "Soup", category: .vegetable, iconName: "cup.and.saucer.fill"),
        CommonFood(name: "Apple", category: .fruit, iconName: "apple.logo"),
        CommonFood(name: "Banana", category: .fruit, iconName: "leaf.fill"),
        CommonFood(name: "Orange", category: .fruit, iconName: "circle.fill"),
        CommonFood(name: "Berries", category: .fruit, iconName: "circle.grid.2x2.fill"),
        CommonFood(name: "Yogurt", category: .dairy, iconName: "cup.and.saucer.fill"),
        CommonFood(name: "Milk", category: .dairy, iconName: "drop.fill"),
        CommonFood(name: "Cheese", category: .dairy, iconName: "square.fill"),
        CommonFood(name: "Tea", category: .liquid, iconName: "cup.and.saucer.fill"),
        CommonFood(name: "Juice", category: .liquid, iconName: "drop.fill"),
        CommonFood(name: "Snack", category: .other, iconName: "fork.knife"),
    ]
}
