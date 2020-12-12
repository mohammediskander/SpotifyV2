//
//  GCMEncrypt.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation
import CryptoKit

class GCMEncrypt {
    static func doGCMEncrypt(_ data: Data, keyData: Data) -> Data? {
        do {
            let key = SymmetricKey(data: keyData)
            
            // Encrypting
            let sealedBox = try AES.GCM.seal(data, using: key)
            let encrypted = sealedBox.combined
            
            return encrypted
        } catch {
            print("ERR::\(error)")
            return nil
        }
    }
    
    class func doGCMDecrypt(_ data: Data, keyData: Data) -> Data? {
        do {
            let key = SymmetricKey(data: keyData)
            
            // Decrypting
            let sealedBoxRestored = try AES.GCM.SealedBox(combined: data)
            let decrypted = try AES.GCM.open(sealedBoxRestored, using: key)
            
            return decrypted
        } catch {
            print("ERR::\(error)")
            return nil
        }
    }
    
    class func generateRandomBytes(_ length: Int) -> Data? {
        if let keyBytes = NSMutableData(length: length) {
            let result = SecRandomCopyBytes(kSecRandomDefault, keyBytes.length, keyBytes.mutableBytes)
            
            if (result != 0) {
                return nil
            }
            
            return keyBytes as Data
        }
        
        return nil
    }
}
