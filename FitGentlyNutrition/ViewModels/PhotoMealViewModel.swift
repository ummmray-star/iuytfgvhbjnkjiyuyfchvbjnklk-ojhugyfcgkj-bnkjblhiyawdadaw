import SwiftUI

@Observable
final class PhotoMealViewModel {
    var capturedImage: UIImage?
    var analysisResult: MealAnalysisResult?
    var isAnalyzing = false
    var errorMessage: String?
    var mealType: MealType = .suggested()

    private let analysisService: MealAnalysisProtocol = MockMealAnalysisService()

    func analyzePhoto() async {
        guard let image = capturedImage else { return }

        isAnalyzing = true
        errorMessage = nil

        do {
            let result = try await analysisService.analyze(image: image)
            analysisResult = result
            HapticService.success()
        } catch {
            errorMessage = "Could not analyze the photo. Try again or log manually."
        }

        isAnalyzing = false
    }

    func buildMealEntry() -> MealEntry? {
        guard let result = analysisResult else { return nil }

        let foodItems = result.detectedFoods.map { food in
            FoodItem(name: food.name, category: food.category, iconName: food.iconName)
        }

        return MealEntry(
            mealType: mealType,
            source: .photo,
            foods: foodItems,
            photoData: capturedImage?.jpegData(compressionQuality: 0.6),
            aiFeedback: result.feedback
        )
    }

    func reset() {
        capturedImage = nil
        analysisResult = nil
        isAnalyzing = false
        errorMessage = nil
    }
}
