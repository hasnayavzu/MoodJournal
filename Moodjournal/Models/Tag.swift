import Foundation
import SwiftData

@Model
final class Tag {
    var id: UUID
    var name: String
    var icon: String
    var isAutomatic: Bool
    var isPredefined: Bool
    var createdAt: Date

    @Relationship(deleteRule: .nullify, inverse: \JournalEntry.tags)
    var entries: [JournalEntry]?

    @Relationship(deleteRule: .nullify)
    var category: TagCategory?

    init(
        name: String,
        icon: String = "tag.fill",
        isAutomatic: Bool = false,
        isPredefined: Bool = false,
        category: TagCategory? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.isAutomatic = isAutomatic
        self.isPredefined = isPredefined
        self.createdAt = Date()
        self.category = category
    }
}

extension Tag {
    static var automaticTextTag: Tag {
        Tag(name: "Text", icon: "text.alignleft", isAutomatic: true)
    }

    static var automaticLocationTag: Tag {
        Tag(name: "Location", icon: "location.fill", isAutomatic: true)
    }

    static var automaticPhotoTag: Tag {
        Tag(name: "Photo", icon: "photo.fill", isAutomatic: true)
    }
}
