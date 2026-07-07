import Foundation

struct HikeEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var trail: String   // Trail
    var value1: Int   // Distance (mi)
    var value2: Int   // Elevation Gain (ft)
    var note: String = ""
}

enum HikejotOptions {
    static let all: [String] = ["Ridge Loop", "Creek Trail", "Summit Path", "Forest Loop", "Canyon Rim", "Other"]
}
