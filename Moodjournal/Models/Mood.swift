import SwiftUI

enum Mood: String, Codable, CaseIterable {
    case terrible = "terrible"
    case bad = "bad"
    case okay = "okay"
    case good = "good"
    case excellent = "excellent"

    var displayName: String {
        switch self {
        case .terrible: return "Terrible"
        case .bad: return "Bad"
        case .okay: return "Okay"
        case .good: return "Good"
        case .excellent: return "Excellent"
        }
    }

    var emoji: String {
        switch self {
        case .terrible: return "😢"
        case .bad: return "😕"
        case .okay: return "😐"
        case .good: return "🙂"
        case .excellent: return "😄"
        }
    }

    var color: Color {
        switch self {
        case .terrible: return .red
        case .bad: return .orange
        case .okay: return .yellow
        case .good: return .green
        case .excellent: return .blue
        }
    }

    var numericValue: Int {
        switch self {
        case .terrible: return 1
        case .bad: return 2
        case .okay: return 3
        case .good: return 4
        case .excellent: return 5
        }
    }
}
