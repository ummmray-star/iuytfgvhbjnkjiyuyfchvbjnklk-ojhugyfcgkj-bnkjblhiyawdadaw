import Foundation
import SwiftData

@Model
final class CaregiverLink {
    var id: UUID
    var caregiverName: String
    var relationshipLabel: String
    var alertThresholdHours: Int
    var isActive: Bool

    init(caregiverName: String, relationshipLabel: String = "Family", alertThresholdHours: Int = 8) {
        self.id = UUID()
        self.caregiverName = caregiverName
        self.relationshipLabel = relationshipLabel
        self.alertThresholdHours = alertThresholdHours
        self.isActive = true
    }
}
