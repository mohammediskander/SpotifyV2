//
//  AlbumRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 10/12/2020.
//

import Foundation

enum AlbumRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/albums")
    
    case getAnAlbum(id: String, market: String?)
    case getAnAlbumTracks(id: String, limit: Int? = 20, offset: Int? = 0, market: String?)
    case getSeveralAlbums(ids: String, market: String?)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case let .getAnAlbum(id, _):
            return String(format: "/%@", id)
        case let .getAnAlbumTracks(id, _, _, _):
            return String(format: "/%@/tracks", id)
        case .getSeveralAlbums:
            return "/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .getAnAlbum(_, market):
            var parameters: Parameters = [:]
            
            guard let market = market else {
                return parameters
            }
            
            parameters["market"] = market
            
            return parameters
        case let .getAnAlbumTracks(_, limit, offset, market):
            var parameters: Parameters = ["limit": limit!, "offset": offset!]
            
            guard let market = market else {
                return parameters
            }
            
            parameters["market"] = market
            
            return parameters
            
        case let .getSeveralAlbums(ids, market):
            var parameters: Parameters = ["ids": ids]
            
            guard let market = market else {
                return parameters
            }
            
            parameters["market"] = market
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: AlbumRouter.baseURL!)
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if accessType == .some(.privateRoute) {
            
            // extract token (aka: oauthToken) from KeyChain
            let token = ""
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
