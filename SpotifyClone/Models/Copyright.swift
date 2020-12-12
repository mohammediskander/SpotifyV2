// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let copyright = try Copyright(json)
//
// To read values from URLs:
//
//   let task = URLSession.shared.copyrightTask(with: url) { copyright, response, error in
//     if let copyright = copyright {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Copyright
struct Copyright: Codable {
    var text, type: String
}

// MARK: Copyright convenience initializers and mutators

extension Copyright {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Copyright.self, from: data)
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
        text: String? = nil,
        type: String? = nil
    ) -> Copyright {
        return Copyright(
            text: text ?? self.text,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
