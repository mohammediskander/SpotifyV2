//
//  KeyChain.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation
import Security

class KeyChain {
    class func save(key: String, data: Data) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlock as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    class func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status : OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfString: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfString as String
        return swiftString
    }
}
