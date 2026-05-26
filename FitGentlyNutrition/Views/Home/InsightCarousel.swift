import SwiftUI

struct InsightCarousel: View {
    let insights: [AIInsight]

    var body: some View {
        VStack(alignment: .leading, spacing: FGSpacing.md) {
            FGSectionHeader("Gentle Insights")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: FGSpacing.md) {
                    ForEach(insights) { insight in
                        FGInsightCard(insight: insight)
                            .frame(width: 300)
                    }
                }
                .padding(.horizontal, FGSpacing.screenPadding)
            }
        }
    }
}
