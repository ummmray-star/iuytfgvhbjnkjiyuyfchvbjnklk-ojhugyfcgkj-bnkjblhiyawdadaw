import SwiftUI
import SwiftData

@Observable
final class HydrationViewModel {
    var todayGlasses: Int = 0
    var goal: Int = 8

    func addGlass(context: ModelContext) {
        let entry = HydrationEntry(glasses: 1)
        context.insert(entry)
        todayGlasses += 1
        HapticService.gentleTap()
    }

    func removeGlass(context: ModelContext) {
        guard todayGlasses > 0 else { return }
        todayGlasses -= 1
        HapticService.selection()
    }

    func refresh(entries: [HydrationEntry]) {
        let today = Date.now.startOfDay
        todayGlasses = entries
            .filter { Calendar.current.isDate($0.timestamp, inSameDayAs: today) }
            .reduce(0) { $0 + $1.glasses }
    }

    var progress: Double {
        guard goal > 0 else { return 0 }
        return Double(todayGlasses) / Double(goal)
    }

    var statusMessage: String {
        let ratio = progress
        if ratio >= 1.0 { return "Hydration goal reached!" }
        if ratio >= 0.75 { return "Almost there!" }
        if ratio >= 0.5 { return "Halfway to your goal." }
        if ratio > 0 { return "Keep sipping throughout the day." }
        return "Start your hydration for today."
    }
}
