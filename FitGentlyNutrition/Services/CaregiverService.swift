import Foundation
import SwiftData

struct CaregiverAlert: Identifiable {
    let id = UUID()
    let caregiverName: String
    let message: String
    let timestamp: Date
}

struct CaregiverService {
    func checkForAlerts(meals: [MealEntry], caregivers: [CaregiverLink]) -> [CaregiverAlert] {
        guard !caregivers.isEmpty else { return [] }

        let activeCaregivers = caregivers.filter(\.isActive)
        guard !activeCaregivers.isEmpty else { return [] }

        var alerts: [CaregiverAlert] = []
        let now = Date.now
        let hour = Calendar.current.component(.hour, from: now)

        guard (7...22).contains(hour) else { return [] }

        let todayMeals = meals.filter { Calendar.current.isDateInToday($0.timestamp) }
        let lastMealTime = todayMeals.map(\.timestamp).max()

        for caregiver in activeCaregivers {
            let threshold = TimeInterval(caregiver.alertThresholdHours * 3600)

            if let lastMeal = lastMealTime {
                if now.timeIntervalSince(lastMeal) > threshold {
                    alerts.append(CaregiverAlert(
                        caregiverName: caregiver.caregiverName,
                        message: "No meal logged in \(caregiver.alertThresholdHours) hours.",
                        timestamp: now
                    ))
                }
            } else if hour >= 12 {
                alerts.append(CaregiverAlert(
                    caregiverName: caregiver.caregiverName,
                    message: "No meals logged today yet.",
                    timestamp: now
                ))
            }
        }

        return alerts
    }
}
