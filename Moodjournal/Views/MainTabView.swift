import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var showingEntryEditor = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }

                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }

                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.fill")
                    }
            }

            Button {
                showingEntryEditor = true
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 16)
        }
        .sheet(isPresented: $showingEntryEditor) {
            EntryEditorView()
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
