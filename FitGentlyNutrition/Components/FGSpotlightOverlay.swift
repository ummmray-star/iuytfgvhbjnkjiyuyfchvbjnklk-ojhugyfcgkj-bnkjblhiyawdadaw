import SwiftUI

struct FGSpotlightOverlay: View {
    let spotlightRect: CGRect
    let message: String
    let onTap: () -> Void

    @State private var isPulsing = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .mask {
                    Rectangle()
                        .overlay {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .frame(width: spotlightRect.width + 16, height: spotlightRect.height + 16)
                                .position(
                                    x: spotlightRect.midX,
                                    y: spotlightRect.midY
                                )
                                .blendMode(.destinationOut)
                        }
                }
                .compositingGroup()

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(FGColors.accent, lineWidth: 3)
                .frame(width: spotlightRect.width + 16, height: spotlightRect.height + 16)
                .position(x: spotlightRect.midX, y: spotlightRect.midY)
                .scaleEffect(isPulsing ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isPulsing)

            VStack(spacing: FGSpacing.sm) {
                Text(message)
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(FGSpacing.lg)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(FGColors.accent)
                    .offset(y: isPulsing ? 4 : 0)
            }
            .position(
                x: spotlightRect.midX,
                y: spotlightRect.maxY + 80
            )
        }
        .ignoresSafeArea()
        .onTapGesture(perform: onTap)
        .onAppear { isPulsing = true }
    }
}
