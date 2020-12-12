//
//  ArtistRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum ArtistRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/artits")
    
    
    case getAnArtitAlbums(id: String, includeGroups: String?, country: String?, limit: Int? = 20, offset: Int? = 0)
    case getAnArtitRelatedArtists(id: String)
    case getAnArtitTopTracks(id: String, market: String)
    case getAnArtit(id: String)
    case getSeveralArtits(ids: [String])
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case let .getAnArtit(id):
            return String(format: "/%@", id)
        case let .getAnArtitRelatedArtists(id):
            return String(format: "/%@/related-artists", id)
        case let .getAnArtitTopTracks(id, _):
            return String(format: "/%@/top-tracks", id)
        case let .getAnArtitAlbums(id, _, _, _, _):
            return String(format: "/%@/albums", id)
        case .getSeveralArtits:
            return "/"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAnArtit(_):
            let parameters: Parameters = [:]
            
            return parameters
        case .getAnArtitAlbums(_, includeGroups: let includeGroups, country: let country, limit: let limit, offset: let offset):
            
            var parameters: Parameters = [:]
            
            if let includeGroups = includeGroups {
                parameters["include_groups"] = includeGroups
            }
            
            if let country = country {
                parameters["country"] = country
            }
            
            if let limit = limit {
                parameters["limit"] = limit
            }
            
            if let offset = offset {
                parameters["offset"] = offset
            }
            
            return parameters
            
        case .getAnArtitRelatedArtists:
            let parameters: Parameters = [:]
            
            return parameters
        case .getAnArtitTopTracks(_, market: let market):
            var parameters: Parameters = [:]
            
            parameters["market"] = market
            
            return parameters
        case .getSeveralArtits(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: ArtistRouter.baseURL!.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if accessType == .some(.privateRoute) {
            
            let token = KeyChain.load(key: "spotify.user.oauthToken")?.to(type: String.self);
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
