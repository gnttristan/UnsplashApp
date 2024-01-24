import Foundation

// MARK: - UnsplashPhoto
struct UnsplashPhoto: Codable {
    let id, slug: String
    let urls: Urls
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, slug, urls, user
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey, CaseIterable {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let username, name: String
    let bio, location: String?
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case bio, location
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small, medium, large: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
