// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artist = try Artist(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.artistTask(with: url) { artist, response, error in
//     if let artist = artist {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Artist
struct Artist: Codable {
    var externalUrls: ExternalUrls?
    var href: String?
    var id, name, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: Artist convenience initializers and mutators

extension Artist {
    init(data: Data) throws {
        self = try JSON.decoder().decode(Artist.self, from: data)
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
        externalUrls: ExternalUrls?? = nil,
        href: String?? = nil,
        id: String?? = nil,
        name: String?? = nil,
        type: String?? = nil,
        uri: String?? = nil
    ) -> Artist {
        return Artist(
            externalUrls: externalUrls ?? self.externalUrls,
            href: href ?? self.href,
            id: id ?? self.id,
            name: name ?? self.name,
            type: type ?? self.type,
            uri: uri ?? self.uri
        )
    }

    func jsonData() throws -> Data {
        return try JSON.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
