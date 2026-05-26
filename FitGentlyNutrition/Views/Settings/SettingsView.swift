import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = SettingsViewModel()

    var body: some View {
        List {
            Section {
                NavigationLink {
                    ReminderSettingsView(viewModel: viewModel)
                } label: {
                    SettingsRow(icon: "bell.fill", title: "Reminders", color: FGColors.warmOrange)
                }

                NavigationLink {
                    AccessibilitySettingsView(viewModel: viewModel)
                } label: {
                    SettingsRow(icon: "textformat.size", title: "Accessibility", color: FGColors.hydrationBlue)
                }

                NavigationLink {
                    CaregiverSettingsView()
                } label: {
                    SettingsRow(icon: "person.2.fill", title: "Family & Caregivers", color: FGColors.accent)
                }

                NavigationLink {
                    HealthKitSettingsView()
                } label: {
                    SettingsRow(icon: "heart.fill", title: "Apple Health", color: .red)
                }
            } header: {
                Text("Preferences")
                    .font(FGTypography.caption)
            }
            .listRowBackground(FGColors.surface)

            Section {
                NavigationLink {
                    AboutView()
                } label: {
                    SettingsRow(icon: "info.circle.fill", title: "About", color: FGColors.textSecondary)
                }

                Button {
                    viewModel.resetOnboarding(appState: appState)
                } label: {
                    SettingsRow(icon: "arrow.counterclockwise", title: "Restart Tutorial", color: FGColors.textSecondary)
                }
            } header: {
                Text("Support")
                    .font(FGTypography.caption)
            }
            .listRowBackground(FGColors.surface)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(FGColors.background)
        .navigationTitle("Settings")
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        HStack(spacing: FGSpacing.md) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(color)
                .frame(width: 28)

            Text(title)
                .font(FGTypography.body)
                .foregroundStyle(FGColors.textPrimary)
        }
        .padding(.vertical, FGSpacing.xs)
    }
}
