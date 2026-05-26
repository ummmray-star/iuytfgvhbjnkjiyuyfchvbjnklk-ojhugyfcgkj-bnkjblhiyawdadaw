import SwiftUI
import SwiftData

struct CaregiverSettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var caregivers: [CaregiverLink]
    @State private var showingAddSheet = false
    @State private var newName = ""
    @State private var newRelationship = "Family"

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: FGSpacing.sm) {
                    Text("Family & caregiver mode lets trusted people check on your meal and hydration habits.")
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)

                    Text("This is completely optional and private.")
                        .font(FGTypography.caption)
                        .foregroundStyle(FGColors.textSecondary)
                }
            }
            .listRowBackground(FGColors.surface)

            Section("Linked Caregivers") {
                if caregivers.isEmpty {
                    Text("No caregivers linked yet.")
                        .font(FGTypography.body)
                        .foregroundStyle(FGColors.textSecondary)
                } else {
                    ForEach(caregivers) { caregiver in
                        HStack {
                            VStack(alignment: .leading, spacing: FGSpacing.xs) {
                                Text(caregiver.caregiverName)
                                    .font(FGTypography.bodyBold)
                                    .foregroundStyle(FGColors.textPrimary)
                                Text(caregiver.relationshipLabel)
                                    .font(FGTypography.caption)
                                    .foregroundStyle(FGColors.textSecondary)
                            }
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { caregiver.isActive },
                                set: { caregiver.isActive = $0 }
                            ))
                            .tint(FGColors.accent)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete(caregivers[index])
                        }
                    }
                }
            }
            .listRowBackground(FGColors.surface)

            Section {
                Button {
                    showingAddSheet = true
                } label: {
                    SettingsRow(icon: "plus.circle.fill", title: "Add Caregiver", color: FGColors.accent)
                }
            }
            .listRowBackground(FGColors.surface)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(FGColors.background)
        .navigationTitle("Caregivers")
        .alert("Add Caregiver", isPresented: $showingAddSheet) {
            TextField("Name", text: $newName)
            TextField("Relationship (e.g. Daughter)", text: $newRelationship)
            Button("Add") {
                guard !newName.isEmpty else { return }
                let link = CaregiverLink(caregiverName: newName, relationshipLabel: newRelationship)
                modelContext.insert(link)
                newName = ""
                newRelationship = "Family"
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}
