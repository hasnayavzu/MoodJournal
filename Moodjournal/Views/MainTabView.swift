import SwiftUI
import SwiftData

enum AppTab: Int, CaseIterable {
    case home
    case calendar
    case stats
    case compose

    var title: String {
        switch self {
        case .home: return "Home"
        case .calendar: return "Calendar"
        case .stats: return "Stats"
        case .compose: return ""
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .calendar: return "calendar"
        case .stats: return "chart.bar.fill"
        case .compose: return "plus"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showingEntryEditor = false

    var body: some View {
        if #available(iOS 26.0, *) {
            TabView(selection: $selectedTab) {
                Tab(AppTab.home.title, systemImage: AppTab.home.icon, value: .home) {
                    HomeView()
                }

                Tab(AppTab.calendar.title, systemImage: AppTab.calendar.icon, value: .calendar) {
                    CalendarView()
                }

                Tab(AppTab.stats.title, systemImage: AppTab.stats.icon, value: .stats) {
                    StatsView()
                }

                Tab(value: .compose, role: .search) {
                    Color.clear
                } label: {
                    Label(AppTab.compose.title, systemImage: AppTab.compose.icon)
                }
            }
            .onChange(of: selectedTab) { oldValue, newValue in
                if newValue == .compose {
                    withAnimation {
                        showingEntryEditor = true
                    }
                    selectedTab = oldValue
                }
            }
            .sheet(isPresented: $showingEntryEditor) {
                EntryEditorView()
            }
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
