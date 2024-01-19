//
//  Keychain.swift
//  ChatSwiftUi
//
//  Created by Manuel Cazalla Colmenero on 17/1/24.
//

import Foundation
import KeychainSwift

class KeychainManager   {
    private let keychain = KeychainSwift()
    
    private enum ApiKey {
        static let token = "ApiToken"
    }
    
    func save(token: String)  {
        keychain.set(token, forKey: "apiToken")
        
        
        
        func getToken() -> String? {
            keychain.get(ApiKey.token)
        }
        
        func deleteToken() {
            keychain.delete(ApiKey.token)
        }
    }
}
