import SwiftUI

struct WhatNextCard: View {
    let score: NutritionScore
    let todayGlasses: Int
    let hydrationGoal: Int
    let mealCount: Int
    var onAddMeal: (() -> Void)? = nil

    var body: some View {
        FGCard {
            VStack(alignment: .leading, spacing: FGSpacing.md) {
                HStack(spacing: FGSpacing.sm) {
                    Text("💡")
                        .font(.system(size: 22))
                    Text("What's Next?")
                        .font(FGTypography.headline)
                        .foregroundStyle(FGColors.textPrimary)
                }

                HStack(spacing: FGSpacing.md) {
                    Text(suggestion.icon)
                        .font(.system(size: 40))
                        .frame(width: 56, height: 56)
                        .background(suggestion.color.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                    Text(suggestion.message)
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                FGButton("Add a Meal", icon: "plus", style: .primary) {
                    onAddMeal?()
                }
            }
        }
    }

    // MARK: - Suggestion logic

    private struct Suggestion {
        let icon: String
        let message: String
        let color: Color
    }

    private var suggestion: Suggestion {
        // Priority: no meal logged > no protein > no produce > low water > generic encouragement
        if mealCount == 0 {
            return Suggestion(
                icon: "🍳",
                message: "You haven't logged a meal yet today. Start with breakfast — even something small counts!",
                color: FGColors.accent
            )
        }
        if score.proteinScore == 0 {
            return Suggestion(
                icon: "🥚",
                message: "Add some protein to your next meal — eggs, chicken, fish, beans, or cheese all count.",
                color: FGColors.warmOrange
            )
        }
        if score.produceScore < 10 {
            return Suggestion(
                icon: "🥦",
                message: "Add some fruits or veggies to your next meal. Even a small portion makes a difference!",
                color: .green
            )
        }
        if todayGlasses < hydrationGoal {
            let remaining = hydrationGoal - todayGlasses
            return Suggestion(
                icon: "💧",
                message: "You're doing great! Try to drink \(remaining) more cup\(remaining == 1 ? "" : "s") of water today.",
                color: FGColors.hydrationBlue
            )
        }
        return Suggestion(
            icon: "🌟",
            message: "You're having a wonderful day! Keep up the great work — your body thanks you.",
            color: FGColors.accent
        )
    }
}
