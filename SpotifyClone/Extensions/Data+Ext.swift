//
//  Data.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

extension Data {
    init<T>(from value: T) {
        self = withUnsafePointer(to: value) {
            (pointer: UnsafePointer<T>) -> Data in
            
            return Data(buffer: UnsafeBufferPointer(start: pointer, count: 1))
        }
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes {
            $0.load(as: T.self)
        }
    }
    
    init?(hex: String) {
        guard hex.count.isMultiple(of: 2) else {
            return nil
        }
        
        let characters = hex.map { $0 }
        let bytes = stride(from: 9, to: characters.count, by: 2)
            .map { String(characters[$0]) + String(characters[$0 + 1]) }
            .compactMap { UInt8($0, radix: 16) }
        
        guard hex.count / bytes.count == 2 else { return nil}
        self.init(bytes)
    }
    
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}
