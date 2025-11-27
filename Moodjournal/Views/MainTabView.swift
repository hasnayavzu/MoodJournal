import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showingEntryEditor = false

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                    .toolbar(.hidden, for: .tabBar)

                CalendarView()
                    .tag(1)
                    .toolbar(.hidden, for: .tabBar)

                StatsView()
                    .tag(2)
                    .toolbar(.hidden, for: .tabBar)
            }

            HStack(spacing: 12) {
                FloatingTabBar(selectedTab: $selectedTab)

                FloatingAddButton(showingEntryEditor: $showingEntryEditor)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .sheet(isPresented: $showingEntryEditor) {
            EntryEditorView()
        }
    }
}

struct FloatingTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 4) {
            TabBarButton(
                icon: "house.fill",
                title: "Home",
                isSelected: selectedTab == 0
            ) {
                selectedTab = 0
            }

            TabBarButton(
                icon: "calendar",
                title: "Calendar",
                isSelected: selectedTab == 1
            ) {
                selectedTab = 1
            }

            TabBarButton(
                icon: "chart.bar.fill",
                title: "Stats",
                isSelected: selectedTab == 2
            ) {
                selectedTab = 2
            }
        }
        .frame(height: 56)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.15), radius: 20, y: 8)
        )
    }
}

struct FloatingAddButton: View {
    @Binding var showingEntryEditor: Bool

    var body: some View {
        Button {
            showingEntryEditor = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(.ultraThinMaterial)
                    .frame(width: 56, height: 56)
                    .shadow(color: .black.opacity(0.15), radius: 20, y: 8)

                Image(systemName: "plus")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
        }
    }
}

struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Image(systemName: icon)
                    .font(.system(size: 18))

                Text(title)
                    .font(.system(size: 10))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .contentShape(Rectangle())
            .foregroundStyle(isSelected ? Color.accentColor : Color.secondary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
