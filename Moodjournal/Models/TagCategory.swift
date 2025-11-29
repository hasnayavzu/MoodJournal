import Foundation
import SwiftData

@Model
final class TagCategory {
    var id: UUID
    var name: String
    var icon: String
    var colorHex: String?
    var isSystemCategory: Bool
    var sortOrder: Int
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Tag.category)
    var tags: [Tag]?

    init(
        name: String,
        icon: String,
        colorHex: String? = nil,
        isSystemCategory: Bool = false,
        sortOrder: Int = 0
    ) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.colorHex = colorHex
        self.isSystemCategory = isSystemCategory
        self.sortOrder = sortOrder
        self.createdAt = Date()
    }
}

extension TagCategory {
    static var weatherCategory: TagCategory {
        TagCategory(
            name: "Weather",
            icon: "cloud.sun.fill",
            isSystemCategory: true,
            sortOrder: 1
        )
    }

    static var emotionsCategory: TagCategory {
        TagCategory(
            name: "Emotions",
            icon: "heart.fill",
            isSystemCategory: true,
            sortOrder: 2
        )
    }

    static var activitiesCategory: TagCategory {
        TagCategory(
            name: "Activities",
            icon: "figure.run",
            isSystemCategory: true,
            sortOrder: 3
        )
    }

    static var peopleCategory: TagCategory {
        TagCategory(
            name: "People",
            icon: "person.2.fill",
            isSystemCategory: true,
            sortOrder: 4
        )
    }
}
