import SwiftUI

struct ReminderSettingsView: View {
    @Bindable var viewModel: SettingsViewModel

    var body: some View {
        List {
            Section {
                Toggle(isOn: $viewModel.mealRemindersEnabled) {
                    VStack(alignment: .leading, spacing: FGSpacing.xs) {
                        Text("Meal Reminders")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textPrimary)
                        Text("Get gentle reminders for breakfast, lunch, and dinner")
                            .font(FGTypography.caption)
                            .foregroundStyle(FGColors.textSecondary)
                    }
                }
                .tint(FGColors.accent)
            }
            .listRowBackground(FGColors.surface)

            Section {
                Toggle(isOn: $viewModel.hydrationRemindersEnabled) {
                    VStack(alignment: .leading, spacing: FGSpacing.xs) {
                        Text("Hydration Reminders")
                            .font(FGTypography.body)
                            .foregroundStyle(FGColors.textPrimary)
                        Text("Periodic reminders to drink water")
                            .font(FGTypography.caption)
                            .foregroundStyle(FGColors.textSecondary)
                    }
                }
                .tint(FGColors.accent)
            }
            .listRowBackground(FGColors.surface)

            Section {
                FGButton("Save Reminders", icon: "checkmark") {
                    Task {
                        _ = await NotificationService.shared.requestPermission()
                        viewModel.updateReminders()
                        HapticService.success()
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(FGColors.background)
        .navigationTitle("Reminders")
    }
}
