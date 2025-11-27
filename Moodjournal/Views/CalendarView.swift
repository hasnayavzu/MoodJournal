import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<JournalEntry> { !$0.isDeleted })
    private var entries: [JournalEntry]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "calendar")
                    .font(.system(size: 60))
                    .foregroundStyle(.secondary)

                Text("Calendar View")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Coming soon! This will show your entries on a monthly calendar with mood colors.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
