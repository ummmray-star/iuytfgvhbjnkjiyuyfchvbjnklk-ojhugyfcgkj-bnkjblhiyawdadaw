import SwiftUI

@Observable
final class PlansViewModel {
    var mealPlans: [MealPlan] = []
    var selectedPlan: MealPlan?

    func loadPlans() {
        mealPlans = Self.samplePlans
    }

    static let samplePlans: [MealPlan] = [
        MealPlan(
            title: "Warm Oatmeal Bowl",
            description: "A comforting breakfast with fiber and natural sweetness.",
            mealType: "Breakfast",
            ingredients: ["Oats", "Milk or water", "Banana", "Honey", "Cinnamon"],
            steps: ["Bring milk to a gentle boil.", "Add oats and stir for 5 minutes.", "Top with sliced banana and honey."],
            prepTimeMinutes: 10,
            tags: ["fiber", "easy"]
        ),
        MealPlan(
            title: "Simple Chicken & Rice",
            description: "A balanced meal with lean protein and energy.",
            mealType: "Lunch",
            ingredients: ["Chicken breast", "Rice", "Olive oil", "Salt", "Lemon"],
            steps: ["Cook rice according to package.", "Season chicken and cook in olive oil.", "Serve together with lemon."],
            prepTimeMinutes: 25,
            tags: ["protein", "balanced"]
        ),
        MealPlan(
            title: "Vegetable Soup",
            description: "Warm, nourishing, and easy to digest.",
            mealType: "Dinner",
            ingredients: ["Carrots", "Potatoes", "Onion", "Celery", "Broth", "Salt"],
            steps: ["Chop vegetables into small pieces.", "Add to pot with broth.", "Simmer for 30 minutes until tender."],
            prepTimeMinutes: 35,
            tags: ["vegetables", "warm"]
        ),
        MealPlan(
            title: "Greek Yogurt with Fruit",
            description: "Quick protein-rich snack with natural vitamins.",
            mealType: "Snack",
            ingredients: ["Greek yogurt", "Berries or banana", "Honey"],
            steps: ["Scoop yogurt into bowl.", "Add fresh fruit on top.", "Drizzle with honey."],
            prepTimeMinutes: 3,
            tags: ["protein", "quick"]
        ),
        MealPlan(
            title: "Scrambled Eggs on Toast",
            description: "Classic breakfast with protein to start the day.",
            mealType: "Breakfast",
            ingredients: ["Eggs", "Bread", "Butter", "Salt", "Pepper"],
            steps: ["Toast bread lightly.", "Scramble eggs in butter over low heat.", "Serve on toast."],
            prepTimeMinutes: 8,
            tags: ["protein", "easy"]
        ),
        MealPlan(
            title: "Baked Fish with Vegetables",
            description: "Light dinner rich in omega-3 and vitamins.",
            mealType: "Dinner",
            ingredients: ["White fish fillet", "Broccoli", "Olive oil", "Lemon", "Garlic"],
            steps: ["Preheat oven to 375F.", "Place fish and broccoli on baking sheet.", "Drizzle with oil and lemon, bake 20 minutes."],
            prepTimeMinutes: 25,
            tags: ["protein", "omega-3"]
        ),
        MealPlan(
            title: "Lentil Stew",
            description: "Hearty and affordable plant-based protein.",
            mealType: "Lunch",
            ingredients: ["Red lentils", "Carrots", "Onion", "Garlic", "Broth", "Cumin"],
            steps: ["Cook onion and garlic until soft.", "Add lentils, carrots, broth, and cumin.", "Simmer 25 minutes."],
            prepTimeMinutes: 30,
            tags: ["fiber", "protein"]
        ),
        MealPlan(
            title: "Banana & Peanut Butter",
            description: "Easy energy boost between meals.",
            mealType: "Snack",
            ingredients: ["Banana", "Peanut butter"],
            steps: ["Slice banana.", "Spread peanut butter on slices."],
            prepTimeMinutes: 2,
            tags: ["energy", "quick"]
        ),
    ]
}
