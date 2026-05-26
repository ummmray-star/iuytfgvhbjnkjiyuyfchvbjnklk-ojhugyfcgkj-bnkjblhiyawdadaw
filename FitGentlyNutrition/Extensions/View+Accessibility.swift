import SwiftUI

extension View {
    func accessibleTapTarget() -> some View {
        self.frame(minWidth: FGSpacing.touchTarget, minHeight: FGSpacing.touchTarget)
    }

    func accessibleCard(label: String, hint: String? = nil) -> some View {
        self
            .accessibilityElement(children: .combine)
            .accessibilityLabel(label)
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(hint.map { Text($0) } ?? Text(""))
    }
}
