import Foundation
import SwiftData

@Model
final class Tag {
    var id: UUID
    var name: String
    var isAutomatic: Bool
    var createdAt: Date

    @Relationship(deleteRule: .nullify, inverse: \JournalEntry.tags)
    var entries: [JournalEntry]?

    init(name: String, isAutomatic: Bool = false) {
        self.id = UUID()
        self.name = name
        self.isAutomatic = isAutomatic
        self.createdAt = Date()
    }
}

extension Tag {
    static var automaticTextTag: Tag {
        Tag(name: "Text", isAutomatic: true)
    }

    static var automaticLocationTag: Tag {
        Tag(name: "Location", isAutomatic: true)
    }

    static var automaticPhotoTag: Tag {
        Tag(name: "Photo", isAutomatic: true)
    }
}
