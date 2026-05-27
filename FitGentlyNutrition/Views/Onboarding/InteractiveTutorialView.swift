import SwiftUI

// Simple 3-slide tour — no forced tapping interactions.
// Each slide explains a feature; user taps "Next" to advance.
struct InteractiveTutorialView: View {
    @Bindable var viewModel: OnboardingViewModel
    @State private var slideIndex = 0

    private let slides: [TourSlide] = [
        TourSlide(
            emoji: "🍽️",
            title: "Log Your Meals",
            body: "Tap the green + button at the bottom of the screen any time you eat. Choose your foods — it only takes a few seconds.",
            accentColor: FGColors.accent
        ),
        TourSlide(
            emoji: "💧",
            title: "Track Your Water",
            body: "Tap + on the Water card each time you drink a glass. Your goal is 8 cups a day — every sip counts!",
            accentColor: FGColors.hydrationBlue
        ),
        TourSlide(
            emoji: "💡",
            title: "Check Your Progress",
            body: "The Home screen shows how you're doing each day. The app will give you gentle reminders and encouragement.",
            accentColor: FGColors.warmOrange
        ),
    ]

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Slide content
            slideView(slides[slideIndex])
                .animation(FGAnimations.gentle, value: slideIndex)

            Spacer()

            // Dot indicators
            HStack(spacing: 10) {
                ForEach(0..<slides.count, id: \.self) { i in
                    Circle()
                        .fill(i == slideIndex ? FGColors.accent : FGColors.divider)
                        .frame(width: i == slideIndex ? 10 : 8, height: i == slideIndex ? 10 : 8)
                        .animation(FGAnimations.gentle, value: slideIndex)
                }
            }
            .padding(.bottom, FGSpacing.lg)

            // Navigation buttons
            bottomNav
        }
    }

    @ViewBuilder
    private func slideView(_ slide: TourSlide) -> some View {
        VStack(spacing: FGSpacing.xl) {
            // Big emoji illustration
            ZStack {
                Circle()
                    .fill(slide.accentColor.opacity(0.12))
                    .frame(width: 130, height: 130)
                Text(slide.emoji)
                    .font(.system(size: 64))
            }

            VStack(spacing: FGSpacing.md) {
                Text(slide.title)
                    .font(FGTypography.title)
                    .foregroundStyle(FGColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text(slide.body)
                    .font(FGTypography.body)
                    .foregroundStyle(FGColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, FGSpacing.screenPadding)
            }
        }
        .padding(.horizontal, FGSpacing.screenPadding)
        .id(slideIndex) // forces redraw on change for transition
    }

    private var bottomNav: some View {
        HStack(spacing: FGSpacing.md) {
            Button("Skip") { viewModel.skip() }
                .font(FGTypography.body)
                .foregroundStyle(FGColors.textSecondary)
                .frame(minHeight: FGSpacing.touchTarget)

            Spacer()

            if slideIndex < slides.count - 1 {
                FGButton("Next", icon: "arrow.right") {
                    withAnimation(FGAnimations.gentle) { slideIndex += 1 }
                    HapticService.selection()
                }
                .frame(maxWidth: 160)
            } else {
                FGButton("Let's Go!", icon: "checkmark") {
                    viewModel.advance()
                }
                .frame(maxWidth: 200)
            }
        }
        .padding(.horizontal, FGSpacing.screenPadding)
        .padding(.vertical, FGSpacing.md)
        .background(FGColors.background)
    }
}

// MARK: - Model

private struct TourSlide {
    let emoji: String
    let title: String
    let body: String
    let accentColor: Color
}
