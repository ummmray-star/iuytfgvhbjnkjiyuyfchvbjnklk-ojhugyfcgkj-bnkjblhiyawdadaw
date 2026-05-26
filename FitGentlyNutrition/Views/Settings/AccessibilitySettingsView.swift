import SwiftUI

struct AccessibilitySettingsView: View {
    @Bindable var viewModel: SettingsViewModel

    var body: some View {
        List {
            Section {
                ForEach(TextSizePreference.allCases) { size in
                    Button {
                        viewModel.textSize = size
                        HapticService.selection()
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: FGSpacing.xs) {
                                Text(size.displayName)
                                    .font(FGTypography.body)
                                    .foregroundStyle(FGColors.textPrimary)

                                Text("Sample text preview")
                                    .font(.system(size: 18 * size.scaleFactor, weight: .regular, design: .rounded))
                                    .foregroundStyle(FGColors.textSecondary)
                            }

                            Spacer()

                            if viewModel.textSize == size {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 22))
                                    .foregroundStyle(FGColors.accent)
                            }
                        }
                    }
                }
            } header: {
                Text("Text Size")
                    .font(FGTypography.caption)
            }
            .listRowBackground(FGColors.surface)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(FGColors.background)
        .navigationTitle("Accessibility")
    }
}
