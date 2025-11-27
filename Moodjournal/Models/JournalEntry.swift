import Foundation
import SwiftData
import CoreLocation

@Model
final class JournalEntry {
    var id: UUID
    var content: String
    var mood: Mood
    var createdAt: Date
    var updatedAt: Date
    var isDeleted: Bool
    var deletedAt: Date?

    var locationName: String?
    var latitude: Double?
    var longitude: Double?

    @Relationship(deleteRule: .nullify)
    var tags: [Tag]?

    init(
        content: String,
        mood: Mood,
        tags: [Tag]? = nil,
        locationName: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = UUID()
        self.content = content
        self.mood = mood
        self.createdAt = Date()
        self.updatedAt = Date()
        self.isDeleted = false
        self.deletedAt = nil
        self.tags = tags
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
    }

    var location: CLLocationCoordinate2D? {
        guard let latitude, let longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var hasText: Bool {
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var hasLocation: Bool {
        locationName != nil && latitude != nil && longitude != nil
    }

    func moveToTrash() {
        isDeleted = true
        deletedAt = Date()
    }

    func restore() {
        isDeleted = false
        deletedAt = nil
    }

    func permanentlyDelete() {
    }

    func updateContent(_ newContent: String) {
        content = newContent
        updatedAt = Date()
    }

    func updateMood(_ newMood: Mood) {
        mood = newMood
        updatedAt = Date()
    }
}

extension JournalEntry {
    var previewText: String {
        let maxLength = 100
        if content.count <= maxLength {
            return content
        }
        let preview = content.prefix(maxLength)
        return String(preview) + "..."
    }

    var wordCount: Int {
        content.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }
}
