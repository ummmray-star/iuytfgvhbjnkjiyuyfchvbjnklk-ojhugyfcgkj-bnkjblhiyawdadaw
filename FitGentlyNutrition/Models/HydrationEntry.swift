import Foundation
import SwiftData

@Model
final class HydrationEntry {
    var id: UUID
    var timestamp: Date
    var glasses: Int

    init(glasses: Int = 1) {
        self.id = UUID()
        self.timestamp = .now
        self.glasses = glasses
    }
}
