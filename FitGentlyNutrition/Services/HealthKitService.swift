import HealthKit

final class HealthKitService {
    private let store = HKHealthStore()

    var isAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }

    func requestAuthorization() async -> Bool {
        guard isAvailable else { return false }

        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .dietaryWater)!,
        ]

        let writeTypes: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .dietaryWater)!,
        ]

        do {
            try await store.requestAuthorization(toShare: writeTypes, read: readTypes)
            return true
        } catch {
            return false
        }
    }

    func syncHydration(glasses: Int, date: Date = .now) async {
        guard let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater) else { return }

        let mlPerGlass = 250.0
        let quantity = HKQuantity(unit: .literUnit(with: .milli), doubleValue: Double(glasses) * mlPerGlass)
        let sample = HKQuantitySample(type: waterType, quantity: quantity, start: date, end: date)

        do {
            try await store.save(sample)
        } catch {
            // HealthKit sync is best-effort
        }
    }

    func readTodaySteps() async -> Int? {
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return nil }

        let startOfDay = Calendar.current.startOfDay(for: .now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: .now, options: .strictStartDate)

        return await withCheckedContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
                let steps = result?.sumQuantity()?.doubleValue(for: .count())
                continuation.resume(returning: steps.map(Int.init))
            }
            store.execute(query)
        }
    }
}
