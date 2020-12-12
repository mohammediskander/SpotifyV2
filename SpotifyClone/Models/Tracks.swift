// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tracks = try Tracks(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.tracksTask(with: url) { tracks, response, error in
//     if let tracks = tracks {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Tracks
struct Tracks: Codable {
    var href: String
    var items: [Item]
    var limit: Int
    var next: JSONNull?
    var offset: Int
    var previous: JSONNull?
    var total: Int
}

// MARK: Tracks convenience initializers and mutators

extension Tracks {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Tracks.self, from: data)
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
        href: String? = nil,
        items: [Item]? = nil,
        limit: Int? = nil,
        next: JSONNull?? = nil,
        offset: Int? = nil,
        previous: JSONNull?? = nil,
        total: Int? = nil
    ) -> Tracks {
        return Tracks(
            href: href ?? self.href,
            items: items ?? self.items,
            limit: limit ?? self.limit,
            next: next ?? self.next,
            offset: offset ?? self.offset,
            previous: previous ?? self.previous,
            total: total ?? self.total
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
