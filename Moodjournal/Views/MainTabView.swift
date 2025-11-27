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
        .glassEffect(shape: .capsule)
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
        }
        .glassEffect(shape: .circle)
    }
}

// iOS 26 Native Liquid Glass Effect
extension View {
    func glassEffect(shape: GlassShape) -> some View {
        self.background {
            ZStack {
                // Base ultra-thin material
                Group {
                    switch shape {
                    case .capsule:
                        Capsule()
                            .fill(.ultraThinMaterial)
                    case .circle:
                        Circle()
                            .fill(.ultraThinMaterial)
                    }
                }

                // Luminosity gradient overlay
                Group {
                    switch shape {
                    case .capsule:
                        Capsule()
                            .fill(
                                .linearGradient(
                                    colors: [
                                        .white.opacity(0.3),
                                        .white.opacity(0.1),
                                        .clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    case .circle:
                        Circle()
                            .fill(
                                .linearGradient(
                                    colors: [
                                        .white.opacity(0.3),
                                        .white.opacity(0.1),
                                        .clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                }

                // Edge highlight stroke
                Group {
                    switch shape {
                    case .capsule:
                        Capsule()
                            .strokeBorder(
                                .linearGradient(
                                    colors: [
                                        .white.opacity(0.5),
                                        .white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.5
                            )
                    case .circle:
                        Circle()
                            .strokeBorder(
                                .linearGradient(
                                    colors: [
                                        .white.opacity(0.5),
                                        .white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.5
                            )
                    }
                }
            }
            .shadow(color: .black.opacity(0.1), radius: 20, y: 10)
            .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
        }
    }
}

enum GlassShape {
    case capsule
    case circle
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
