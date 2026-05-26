import Foundation
import SwiftData

enum InsightCategory: String, Codable {
    case encouragement, suggestion, alert
}

@Model
final class AIInsight {
    var id: UUID
    var generatedDate: Date
    var message: String
    var categoryRaw: String
    var priority: Int
    var isDismissed: Bool

    var category: InsightCategory {
        get { InsightCategory(rawValue: categoryRaw) ?? .suggestion }
        set { categoryRaw = newValue.rawValue }
    }

    init(message: String, category: InsightCategory, priority: Int = 3) {
        self.id = UUID()
        self.generatedDate = .now
        self.message = message
        self.categoryRaw = category.rawValue
        self.priority = priority
        self.isDismissed = false
    }
}
