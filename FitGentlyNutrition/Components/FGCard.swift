import SwiftUI

struct FGCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(FGSpacing.lg)
            .background(FGColors.surface)
            .clipShape(RoundedRectangle(cornerRadius: FGSpacing.cardRadius, style: .continuous))
            .fgCardShadow()
    }
}
