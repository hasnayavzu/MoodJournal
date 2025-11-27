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

            LiquidGlassButton {
                showingEntryEditor = true
            }
            .padding(.trailing, 20)
            .padding(.bottom, 16)
        }
        .sheet(isPresented: $showingEntryEditor) {
            EntryEditorView()
        }
    }
}

struct LiquidGlassButton: View {
    let action: () -> Void
    @State private var isPressed = false

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .frame(width: 60, height: 60)
                .background {
                    ZStack {
                        // Base material
                        Circle()
                            .fill(.ultraThinMaterial)

                        // Luminosity gradient
                        Circle()
                            .fill(
                                .linearGradient(
                                    colors: [
                                        .white.opacity(isPressed ? 0.4 : 0.3),
                                        .white.opacity(isPressed ? 0.2 : 0.1),
                                        .clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )

                        // Edge highlight
                        Circle()
                            .strokeBorder(
                                .linearGradient(
                                    colors: [
                                        .white.opacity(0.6),
                                        .white.opacity(0.2)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.5
                            )
                    }
                    .shadow(color: .black.opacity(isPressed ? 0.15 : 0.1), radius: isPressed ? 12 : 20, y: isPressed ? 6 : 10)
                    .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                }
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(InteractiveButtonStyle(isPressed: $isPressed))
    }
}

struct InteractiveButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = newValue
                }
            }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
