//
//  Hashing.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation
import CryptoKit

class Hashing {
    class func sha256(_ string: String) -> String {
        guard let inputData = string.data(using: .utf8) else {
            return ""
        }
        
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    class func sha512(_ string: String) -> String {
        guard let inputData = string.data(using: .utf8) else {
            return ""
        }
        
        let hashed = SHA512.hash(data: inputData)
        let hashString = hashed.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}
