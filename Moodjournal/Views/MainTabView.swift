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
        HStack(spacing: 6) {
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
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background {
            ZStack {
                Capsule()
                    .fill(.ultraThinMaterial)

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.1),
                                Color.clear
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                Capsule()
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.5),
                                Color.white.opacity(0.2)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.5
                    )
            }
            .shadow(color: .black.opacity(0.1), radius: 20, y: 10)
            .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
        }
    }
}

struct FloatingAddButton: View {
    @Binding var showingEntryEditor: Bool

    var body: some View {
        Button {
            showingEntryEditor = true
        } label: {
            Image(systemName: "plus")
                .font(.body.weight(.semibold))
                .frame(width: 48, height: 48)
                .background {
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)

                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.3),
                                        Color.white.opacity(0.1),
                                        Color.clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )

                        Circle()
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.5),
                                        Color.white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.5
                            )
                    }
                    .shadow(color: .black.opacity(0.1), radius: 20, y: 10)
                    .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
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
            .frame(width: 70, height: 44)
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
