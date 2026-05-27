import SwiftUI

struct MoreView: View {
    var body: some View {
        List {
            // MARK: Explore
            Section {
                NavigationLink(destination: PlansView()) {
                    MoreRow(icon: "list.clipboard.fill", label: "Meal Plans", color: FGColors.accent)
                }
                NavigationLink(destination: PlansView()) {
                    MoreRow(icon: "book.fill", label: "Easy Recipes", color: FGColors.warmOrange)
                }
            } header: {
                Text("Explore")
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(Color(hex: "#4A7C59"))
                    .textCase(nil)
            }

            // MARK: Settings
            Section {
                NavigationLink(destination: SettingsView()) {
                    MoreRow(icon: "bell.fill", label: "Reminders", color: FGColors.hydrationBlue)
                }
                NavigationLink(destination: SettingsView()) {
                    MoreRow(icon: "textformat.size", label: "Accessibility", color: FGColors.accent)
                }
                NavigationLink(destination: SettingsView()) {
                    MoreRow(icon: "person.2.fill", label: "Family & Caregivers", color: FGColors.warmOrange)
                }
                NavigationLink(destination: SettingsView()) {
                    MoreRow(icon: "heart.fill", label: "Apple Health", color: .red)
                }
                NavigationLink(destination: SettingsView()) {
                    MoreRow(icon: "info.circle.fill", label: "About", color: FGColors.textSecondary)
                }
            } header: {
                Text("Settings")
                    .font(FGTypography.bodyBold)
                    .foregroundStyle(Color(hex: "#4A7C59"))
                    .textCase(nil)
            }
        }
        .listStyle(.insetGrouped)
        .background(FGColors.background)
        .scrollContentBackground(.hidden)
        .navigationTitle("More")
    }
}

// MARK: - MoreRow

private struct MoreRow: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(color)
            }

            Text(label)
                .font(FGTypography.body)
                .foregroundStyle(FGColors.textPrimary)
        }
        .padding(.vertical, FGSpacing.xs)
    }
}
