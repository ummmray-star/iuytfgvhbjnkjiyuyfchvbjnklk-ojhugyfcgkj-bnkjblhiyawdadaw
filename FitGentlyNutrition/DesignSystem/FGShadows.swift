import SwiftUI

struct FGCardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
    }
}

struct FGRaisedShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .black.opacity(0.10), radius: 8, x: 0, y: 2)
    }
}

extension View {
    func fgCardShadow() -> some View {
        modifier(FGCardShadow())
    }

    func fgRaisedShadow() -> some View {
        modifier(FGRaisedShadow())
    }
}
