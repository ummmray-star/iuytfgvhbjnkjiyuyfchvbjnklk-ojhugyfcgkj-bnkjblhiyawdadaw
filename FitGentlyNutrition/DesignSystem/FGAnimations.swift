import SwiftUI

enum FGAnimations {
    static let gentle = Animation.easeInOut(duration: 0.35)
    static let spring = Animation.spring(response: 0.4, dampingFraction: 0.75)
    static let slow = Animation.easeInOut(duration: 0.6)
    static let bounce = Animation.spring(response: 0.5, dampingFraction: 0.6)
}
