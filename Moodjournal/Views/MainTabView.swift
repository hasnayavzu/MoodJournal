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

                Color.clear
                    .tag(2)

                StatsView()
                    .tag(3)
            }

            FloatingTabBar(
                selectedTab: $selectedTab,
                showingEntryEditor: $showingEntryEditor
            )
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
    @Binding var showingEntryEditor: Bool

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

            Button {
                showingEntryEditor = true
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 56, height: 56)

                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .offset(y: -8)

            TabBarButton(
                icon: "chart.bar.fill",
                title: "Stats",
                isSelected: selectedTab == 3
            ) {
                selectedTab = 3
            }

            Spacer()
                .frame(width: 60)
        }
        .frame(height: 60)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
        )
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
