//
//  SearchRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum SearchRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/search")
    
    case searchForAnItem(q: String, type: String, market: String?, limit: Int = 20, offset: Int = 0, includeExternal: String?)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .searchForAnItem:
            return "/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchForAnItem(q: let q, type: let type, market: let market, limit: let limit, offset: let offset, includeExternal: let includeExternal):
            var parameter: Parameters = [:]
            
            parameter["q"] = q
            parameter["type"] = type
            parameter["limit"] = limit
            parameter["offset"] = offset
            
            if let market = market {
                parameter["market"] = market
            }
            
            if let includeExternal = includeExternal {
                parameter["include_external"] = includeExternal
            }
            
            return parameter
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: SearchRouter.baseURL!.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if accessType == .some(.privateRoute) {
            
            let token = KeyChain.load(key: "spotify.user.oauthToken")?.to(type: String.self)
            urlRequest.allHTTPHeaderFields?["Authorization"] = token
        }
        
        if let parameters = parameters {
            do {
                if method == .get {
                    urlRequest.queryItems = parameters.toURLQueryItems()
                } else {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            }
        }
        
        return urlRequest
    }
    
    
}
