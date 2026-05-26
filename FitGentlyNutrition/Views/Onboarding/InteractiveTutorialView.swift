import SwiftUI

struct InteractiveTutorialView: View {
    @Bindable var viewModel: OnboardingViewModel
    @State private var tutorialStep = 0
    @State private var demoGlasses = 0
    @State private var demoFoodSelected = false

    var body: some View {
        VStack(spacing: FGSpacing.xl) {
            Spacer()

            VStack(spacing: FGSpacing.lg) {
                Text("Quick Tour")
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)

                Group {
                    switch tutorialStep {
                    case 0:
                        tutorialHydration
                    case 1:
                        tutorialMeal
                    default:
                        tutorialComplete
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
            }

            Spacer()

            HStack {
                Button("Skip") { viewModel.skip() }
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)

                Spacer()
            }
            .padding(.horizontal, FGSpacing.screenPadding)
            .padding(.bottom, FGSpacing.xxl)
        }
    }

    private var tutorialHydration: some View {
        VStack(spacing: FGSpacing.lg) {
            Text("Try tapping to add water")
                .font(FGTypography.headline)
                .foregroundStyle(FGColors.textSecondary)

            FGCard {
                VStack(spacing: FGSpacing.md) {
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundStyle(FGColors.hydrationBlue)
                        Text("Hydration")
                            .font(FGTypography.headline)
                            .foregroundStyle(FGColors.textPrimary)
                        Spacer()
                    }

                    FGGlassCounter(
                        current: demoGlasses,
                        goal: 8,
                        onAdd: {
                            demoGlasses += 1
                            if demoGlasses >= 3 {
                                withAnimation(FGAnimations.gentle) {
                                    tutorialStep = 1
                                }
                            }
                        },
                        onRemove: { demoGlasses = max(0, demoGlasses - 1) }
                    )
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            Text("Tap + three times to continue")
                .font(FGTypography.caption)
                .foregroundStyle(FGColors.accent)
        }
    }

    private var tutorialMeal: some View {
        VStack(spacing: FGSpacing.lg) {
            Text("Tap a food to log it")
                .font(FGTypography.headline)
                .foregroundStyle(FGColors.textSecondary)

            HStack(spacing: FGSpacing.md) {
                ForEach(CommonFood.all.prefix(3)) { food in
                    FGFoodButton(
                        food: food,
                        isSelected: demoFoodSelected && food.name == "Eggs",
                        action: {
                            demoFoodSelected = true
                            HapticService.success()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                withAnimation(FGAnimations.gentle) {
                                    tutorialStep = 2
                                }
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, FGSpacing.screenPadding)

            Text("Tap any food to continue")
                .font(FGTypography.caption)
                .foregroundStyle(FGColors.accent)
        }
    }

    private var tutorialComplete: some View {
        VStack(spacing: FGSpacing.lg) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 56, weight: .light))
                .foregroundStyle(FGColors.accent)

            Text("You're a natural!")
                .font(FGTypography.title)
                .foregroundStyle(FGColors.textPrimary)

            Text("That's all you need to know.\nLet's get started.")
                .font(FGTypography.body)
                .foregroundStyle(FGColors.textSecondary)
                .multilineTextAlignment(.center)

            FGButton("Continue", icon: "arrow.right") {
                viewModel.advance()
            }
            .frame(maxWidth: 200)
        }
    }
}
