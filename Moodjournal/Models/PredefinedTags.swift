import Foundation

struct PredefinedTags {
    // Weather tags
    static let weatherTags = [
        TagData(name: "Sunny", icon: "sun.max.fill"),
        TagData(name: "Cloudy", icon: "cloud.fill"),
        TagData(name: "Rainy", icon: "cloud.rain.fill"),
        TagData(name: "Snowy", icon: "snowflake"),
        TagData(name: "Stormy", icon: "cloud.bolt.fill"),
        TagData(name: "Windy", icon: "wind"),
        TagData(name: "Foggy", icon: "cloud.fog.fill"),
    ]

    // Emotion tags
    static let emotionTags = [
        TagData(name: "Happy", icon: "face.smiling"),
        TagData(name: "Sad", icon: "cloud.rain"),
        TagData(name: "Anxious", icon: "bolt.heart.fill"),
        TagData(name: "Excited", icon: "star.fill"),
        TagData(name: "Calm", icon: "leaf.fill"),
        TagData(name: "Angry", icon: "flame.fill"),
        TagData(name: "Grateful", icon: "heart.fill"),
        TagData(name: "Stressed", icon: "exclamationmark.triangle.fill"),
        TagData(name: "Peaceful", icon: "sparkles"),
        TagData(name: "Lonely", icon: "person.fill"),
    ]

    // Activity tags
    static let activityTags = [
        TagData(name: "Exercise", icon: "figure.run"),
        TagData(name: "Reading", icon: "book.fill"),
        TagData(name: "Gaming", icon: "gamecontroller.fill"),
        TagData(name: "Music", icon: "music.note"),
        TagData(name: "Cooking", icon: "frying.pan.fill"),
        TagData(name: "Socializing", icon: "person.2.fill"),
        TagData(name: "Working", icon: "briefcase.fill"),
        TagData(name: "Studying", icon: "graduationcap.fill"),
        TagData(name: "Shopping", icon: "cart.fill"),
        TagData(name: "Traveling", icon: "airplane"),
        TagData(name: "Meditation", icon: "sparkles"),
        TagData(name: "Walking", icon: "figure.walk"),
    ]

    // People tags
    static let peopleTags = [
        TagData(name: "Friends", icon: "person.2.fill"),
        TagData(name: "Family", icon: "house.fill"),
        TagData(name: "Partner", icon: "heart.fill"),
        TagData(name: "Colleagues", icon: "briefcase.fill"),
        TagData(name: "Alone", icon: "person.fill"),
        TagData(name: "Pet", icon: "pawprint.fill"),
    ]

    static func createPredefinedCategories() -> [(category: TagCategory, tags: [TagData])] {
        return [
            (TagCategory.weatherCategory, weatherTags),
            (TagCategory.emotionsCategory, emotionTags),
            (TagCategory.activitiesCategory, activityTags),
            (TagCategory.peopleCategory, peopleTags),
        ]
    }
}

struct TagData {
    let name: String
    let icon: String
}
