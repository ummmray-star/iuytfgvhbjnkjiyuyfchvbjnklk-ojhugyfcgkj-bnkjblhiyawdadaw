import SwiftUI

struct PlansView: View {
    @State private var viewModel = PlansViewModel()
    @State private var selectedMealType: String = "All"

    private var mealTypes: [String] {
        ["All"] + Array(Set(viewModel.mealPlans.map(\.mealType))).sorted()
    }

    private var filteredPlans: [MealPlan] {
        if selectedMealType == "All" { return viewModel.mealPlans }
        return viewModel.mealPlans.filter { $0.mealType == selectedMealType }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: FGSpacing.lg) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: FGSpacing.sm) {
                        ForEach(mealTypes, id: \.self) { type in
                            Button {
                                withAnimation(FGAnimations.gentle) {
                                    selectedMealType = type
                                }
                            } label: {
                                Text(type)
                                    .font(FGTypography.captionBold)
                                    .padding(.horizontal, FGSpacing.md)
                                    .padding(.vertical, FGSpacing.sm)
                                    .background(selectedMealType == type ? FGColors.accent : FGColors.surfaceSecondary)
                                    .foregroundStyle(selectedMealType == type ? FGColors.textOnAccent : FGColors.textPrimary)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal, FGSpacing.screenPadding)
                }

                ForEach(filteredPlans) { plan in
                    NavigationLink(destination: RecipeDetailView(plan: plan)) {
                        MealIdeaCard(plan: plan)
                    }
                    .padding(.horizontal, FGSpacing.screenPadding)
                }
            }
            .padding(.bottom, FGSpacing.xxl)
        }
        .background(FGColors.background)
        .navigationTitle("Meal Ideas")
        .onAppear { viewModel.loadPlans() }
    }
}
