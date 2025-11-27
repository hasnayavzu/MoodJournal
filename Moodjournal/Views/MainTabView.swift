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

                CalendarView()
                    .tag(1)

                StatsView()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

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
        HStack(spacing: 0) {
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
        .frame(height: 60)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
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
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.accentColor)
                    .frame(width: 60, height: 60)
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)

                Image(systemName: "plus")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
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
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))

                Text(title)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(isSelected ? Color.accentColor : Color.secondary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
