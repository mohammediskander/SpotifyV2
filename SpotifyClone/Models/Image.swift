// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let image = try Image(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.imageTask(with: url) { image, response, error in
//     if let image = image {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Image
struct Image: Codable {
    var height: Int
    var url: String
    var width: Int
}

// MARK: Image convenience initializers and mutators

extension Image {
    init(data: Data) throws {
        self = try JSON.decoder().decode(Image.self, from: data)
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
        height: Int? = nil,
        url: String? = nil,
        width: Int? = nil
    ) -> Image {
        return Image(
            height: height ?? self.height,
            url: url ?? self.url,
            width: width ?? self.width
        )
    }

    func jsonData() throws -> Data {
        return try JSON.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
