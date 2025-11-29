import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("General") {
                    HStack {
                        Label("App Version", systemImage: "info.circle")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Appearance") {
                    Label("Theme", systemImage: "paintbrush")
                    Label("Accent Color", systemImage: "palette")
                }

                Section("Data") {
                    Label("Export Data", systemImage: "square.and.arrow.up")
                    Label("Backup", systemImage: "cloud.fill")
                }

                Section("About") {
                    Label("Privacy Policy", systemImage: "hand.raised")
                    Label("Terms of Service", systemImage: "doc.text")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.body.weight(.semibold))
                            Text("Back")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
