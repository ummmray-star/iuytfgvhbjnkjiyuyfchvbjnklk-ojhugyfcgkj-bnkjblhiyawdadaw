import SwiftUI

struct HealthKitSettingsView: View {
    @State private var isConnected = false
    @State private var isLoading = false
    private let healthKit = HealthKitService()

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: FGSpacing.sm) {
                    Text("Connect to Apple Health to sync your hydration data and view your daily steps.")
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)
                }
            }
            .listRowBackground(FGColors.surface)

            Section {
                HStack {
                    SettingsRow(icon: "heart.fill", title: "Apple Health", color: .red)

                    Spacer()

                    if isConnected {
                        Text("Connected")
                            .font(FGTypography.captionBold)
                            .foregroundStyle(FGColors.accent)
                    } else {
                        Button("Connect") {
                            isLoading = true
                            Task {
                                isConnected = await healthKit.requestAuthorization()
                                isLoading = false
                            }
                        }
                        .font(FGTypography.captionBold)
                        .foregroundStyle(FGColors.accentDark)
                        .disabled(isLoading)
                    }
                }
            }
            .listRowBackground(FGColors.surface)

            if !healthKit.isAvailable {
                Section {
                    Text("Apple Health is not available on this device.")
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)
                }
                .listRowBackground(FGColors.surface)
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(FGColors.background)
        .navigationTitle("Apple Health")
    }
}
