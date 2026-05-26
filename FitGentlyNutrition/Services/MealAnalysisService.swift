import UIKit

struct MealAnalysisResult {
    let detectedFoods: [CommonFood]
    let feedback: String
    let confidence: Double
}

protocol MealAnalysisProtocol {
    func analyze(image: UIImage) async throws -> MealAnalysisResult
}

final class MockMealAnalysisService: MealAnalysisProtocol {
    func analyze(image: UIImage) async throws -> MealAnalysisResult {
        try await Task.sleep(for: .seconds(1.5))

        let sampleFoods = Array(CommonFood.all.shuffled().prefix(3))
        let feedbacks = [
            "This looks like a balanced meal!",
            "Great protein choice. Consider adding a vegetable.",
            "Nice variety! This meal has good fiber.",
            "Good source of energy. A glass of water would complement this.",
            "Healthy and simple. Well done!",
        ]

        return MealAnalysisResult(
            detectedFoods: sampleFoods,
            feedback: feedbacks.randomElement() ?? "Looks good!",
            confidence: Double.random(in: 0.7...0.95)
        )
    }
}
