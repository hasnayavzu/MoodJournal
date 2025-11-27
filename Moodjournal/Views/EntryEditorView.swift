import SwiftUI
import SwiftData

struct EntryEditorView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var content: String = ""
    @State private var selectedMood: Mood = .okay
    @State private var selectedTags: Set<Tag> = []

    @Query private var allTags: [Tag]

    let entryToEdit: JournalEntry?

    init(entry: JournalEntry? = nil) {
        self.entryToEdit = entry
        if let entry = entry {
            _content = State(initialValue: entry.content)
            _selectedMood = State(initialValue: entry.mood)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        moodSelector

                        Divider()

                        textEditor
                    }
                    .padding()
                }
            }
            .navigationTitle(entryToEdit == nil ? "New Entry" : "Edit Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                    .fontWeight(.semibold)
                    .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private var moodSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("How are you feeling?")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Mood.allCases, id: \.self) { mood in
                        MoodButton(
                            mood: mood,
                            isSelected: selectedMood == mood
                        ) {
                            withAnimation(.spring(response: 0.3)) {
                                selectedMood = mood
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private var textEditor: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("What's on your mind?")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                if content.isEmpty {
                    Text("Start writing...")
                        .foregroundStyle(.secondary.opacity(0.5))
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }

                TextEditor(text: $content)
                    .frame(minHeight: 200)
                    .scrollContentBackground(.hidden)
            }

            HStack {
                Text("\(content.split(separator: " ").count) words")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
        }
    }

    private func saveEntry() {
        if let entryToEdit = entryToEdit {
            entryToEdit.updateContent(content)
            entryToEdit.updateMood(selectedMood)
        } else {
            let newEntry = JournalEntry(
                content: content,
                mood: selectedMood
            )

            if newEntry.hasText {
                let textTag = allTags.first(where: { $0.name == "Text" && $0.isAutomatic }) ?? Tag.automaticTextTag
                if textTag.entries == nil {
                    modelContext.insert(textTag)
                }
                newEntry.tags = [textTag]
            }

            modelContext.insert(newEntry)
        }

        dismiss()
    }
}

struct MoodButton: View {
    let mood: Mood
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(mood.emoji)
                    .font(.system(size: 44))

                Text(mood.displayName)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .frame(width: 80, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? mood.color.opacity(0.2) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(
                        isSelected ? mood.color : Color.secondary.opacity(0.3),
                        lineWidth: isSelected ? 3 : 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    EntryEditorView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}

#Preview("Edit Entry") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: JournalEntry.self, configurations: config)
    let entry = JournalEntry(content: "Sample entry to edit", mood: .good)
    container.mainContext.insert(entry)

    return EntryEditorView(entry: entry)
        .modelContainer(container)
}
