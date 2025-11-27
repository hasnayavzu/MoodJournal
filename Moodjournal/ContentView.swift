//
//  ContentView.swift
//  Moodjournal
//
//  Created by Hasan Yavuz on 2025/11/27.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<JournalEntry> { !$0.isDeleted }, sort: \JournalEntry.createdAt, order: .reverse)
    private var entries: [JournalEntry]

    var body: some View {
        NavigationStack {
            List {
                ForEach(entries) { entry in
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
                .onDelete(perform: deleteEntries)
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addEntry) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addEntry() {
        withAnimation {
            let newEntry = JournalEntry(
                content: "Sample entry created at \(Date().formatted(date: .abbreviated, time: .shortened))",
                mood: .good
            )
            modelContext.insert(newEntry)
        }
    }

    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                entries[index].moveToTrash()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
