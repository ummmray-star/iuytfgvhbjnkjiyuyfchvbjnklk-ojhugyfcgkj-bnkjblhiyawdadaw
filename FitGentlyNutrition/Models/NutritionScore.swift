import Foundation

struct NutritionScore {
    let total: Int
    let varietyScore: Int
    let proteinScore: Int
    let produceScore: Int
    let regularityScore: Int
    let feedback: String

    static let empty = NutritionScore(
        total: 0,
        varietyScore: 0,
        proteinScore: 0,
        produceScore: 0,
        regularityScore: 0,
        feedback: "Log your first meal to get started!"
    )
}
