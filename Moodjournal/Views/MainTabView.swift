import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showingEntryEditor = false

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(1)

            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(2)

            Color.clear
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                        .environment(\.symbolRenderingMode, .palette)
                        .foregroundStyle(.white, .blue)
                }
                .tag(3)
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == 3 {
                showingEntryEditor = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    selectedTab = oldValue
                }
            }
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
