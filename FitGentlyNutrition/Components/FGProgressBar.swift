import SwiftUI

struct FGProgressBar: View {
    let progress: Double
    let color: Color
    let height: CGFloat

    init(progress: Double, color: Color = FGColors.accent, height: CGFloat = 12) {
        self.progress = min(max(progress, 0), 1)
        self.color = color
        self.height = height
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(color.opacity(0.15))

                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(color)
                    .frame(width: geometry.size.width * progress)
                    .animation(FGAnimations.gentle, value: progress)
            }
        }
        .frame(height: height)
        .accessibilityLabel("\(Int(progress * 100)) percent complete")
    }
}
