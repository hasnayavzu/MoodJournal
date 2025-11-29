import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<JournalEntry> { !$0.isDeleted }, sort: \JournalEntry.createdAt, order: .reverse)
    private var entries: [JournalEntry]

    @State private var entryToEdit: JournalEntry?
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            List {
                if entries.isEmpty {
                    emptyState
                } else {
                    ForEach(entries) { entry in
                        EntryRow(entry: entry)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                entryToEdit = entry
                            }
                    }
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(item: $entryToEdit) { entry in
                EntryEditorView(entry: entry)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text("No Entries Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Tap the + button below to create your first journal entry")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.top, 100)
    }
}

struct EntryRow: View {
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(entry.mood.emoji)
                    .font(.title2)
                Text(entry.mood.displayName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(entry.createdAt, format: .dateTime.month().day())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if entry.hasText {
                Text(entry.previewText)
                    .font(.body)
                    .lineLimit(2)
            }

            if let tags = entry.tags, !tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(tags, id: \.id) { tag in
                            Text(tag.name)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
