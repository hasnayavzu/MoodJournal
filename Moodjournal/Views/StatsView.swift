import SwiftUI
import SwiftData

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<JournalEntry> { !$0.isDeleted })
    private var entries: [JournalEntry]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if entries.isEmpty {
                        emptyState
                    } else {
                        basicStats
                    }
                }
                .padding()
            }
            .navigationTitle("Stats")
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.bar")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            Text("No Stats Yet")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Start journaling to see your mood patterns and statistics")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 100)
    }

    private var basicStats: some View {
        VStack(spacing: 16) {
            StatCard(
                title: "Total Entries",
                value: "\(entries.count)",
                icon: "book.fill",
                color: .blue
            )

            StatCard(
                title: "This Week",
                value: "\(entriesThisWeek)",
                icon: "calendar",
                color: .green
            )

            StatCard(
                title: "Average Mood",
                value: averageMoodText,
                icon: "face.smiling",
                color: .orange
            )

            VStack(alignment: .leading, spacing: 12) {
                Text("Mood Distribution")
                    .font(.headline)

                ForEach(Mood.allCases, id: \.self) { mood in
                    let count = entries.filter { $0.mood == mood }.count
                    let percentage = entries.isEmpty ? 0 : Double(count) / Double(entries.count) * 100

                    HStack {
                        Text(mood.emoji)
                        Text(mood.displayName)
                            .font(.subheadline)
                        Spacer()
                        Text("\(count)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.secondary.opacity(0.2))
                                .frame(height: 8)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(mood.color)
                                .frame(width: geometry.size.width * (percentage / 100), height: 8)
                        }
                    }
                    .frame(height: 8)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
        }
    }

    private var entriesThisWeek: Int {
        let calendar = Calendar.current
        let now = Date()
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: now)!

        return entries.filter { $0.createdAt >= weekAgo }.count
    }

    private var averageMoodText: String {
        guard !entries.isEmpty else { return "N/A" }

        let sum = entries.reduce(0) { $0 + $1.mood.numericValue }
        let average = Double(sum) / Double(entries.count)

        return String(format: "%.1f / 5", average)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(color.opacity(0.2))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.title2)
                    .fontWeight(.semibold)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

#Preview {
    StatsView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
