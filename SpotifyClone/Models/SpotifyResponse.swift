// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let spotifyResponse = try SpotifyResponse(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.spotifyResponseTask(with: url) { spotifyResponse, response, error in
//     if let spotifyResponse = spotifyResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - SpotifyResponse
struct SpotifyResponse: Codable {
    var albums: [Album]
}

// MARK: SpotifyResponse convenience initializers and mutators

extension SpotifyResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SpotifyResponse.self, from: data)
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
        albums: [Album]? = nil
    ) -> SpotifyResponse {
        return SpotifyResponse(
            albums: albums ?? self.albums
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
