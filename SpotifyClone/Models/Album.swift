// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let album = try Album(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.albumTask(with: url) { album, response, error in
//     if let album = album {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Album
struct Album: Codable {
//    var albumType: String
    var artists: [Artist]
    var availableMarkets: [String]
    var copyrights: [Copyright]
    var externalIDS: ExternalIDS
    var externalUrls: ExternalUrls
    var genres: [JSONAny]
    var href: String
    var id: String
    var images: [Image]
    var name: String
    var popularity: Int
    var releaseDate, releaseDatePrecision: String
    var tracks: Tracks
    var type, uri: String

    enum CodingKeys: String, CodingKey {
//        case albumType
        case artists
        case availableMarkets
        case copyrights
        case externalIDS
        case externalUrls
        case genres, href, id, images, name, popularity
        case releaseDate
        case releaseDatePrecision
        case tracks, type, uri
    }
}

// MARK: Album convenience initializers and mutators

extension Album {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Album.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        albumType: String? = nil,
        artists: [Artist]? = nil,
        availableMarkets: [String]? = nil,
        copyrights: [Copyright]? = nil,
        externalIDS: ExternalIDS? = nil,
        externalUrls: ExternalUrls? = nil,
        genres: [JSONAny]? = nil,
        href: String? = nil,
        id: String? = nil,
        images: [Image]? = nil,
        name: String? = nil,
        popularity: Int? = nil,
        releaseDate: String? = nil,
        releaseDatePrecision: String? = nil,
        tracks: Tracks? = nil,
        type: String? = nil,
        uri: String? = nil
    ) -> Album {
        return Album(
            albumType: albumType ?? self.albumType,
            artists: artists ?? self.artists,
            availableMarkets: availableMarkets ?? self.availableMarkets,
            copyrights: copyrights ?? self.copyrights,
            externalIDS: externalIDS ?? self.externalIDS,
            externalUrls: externalUrls ?? self.externalUrls,
            genres: genres ?? self.genres,
            href: href ?? self.href,
            id: id ?? self.id,
            images: images ?? self.images,
            name: name ?? self.name,
            popularity: popularity ?? self.popularity,
            releaseDate: releaseDate ?? self.releaseDate,
            releaseDatePrecision: releaseDatePrecision ?? self.releaseDatePrecision,
            tracks: tracks ?? self.tracks,
            type: type ?? self.type,
            uri: uri ?? self.uri
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
