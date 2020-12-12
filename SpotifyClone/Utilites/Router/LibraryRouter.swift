//
//  LibraryRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum LibraryRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/me")
    
    case removeAlbumsForCurrentUser(ids: [String])
    case removeUserSavedShows(ids: [String])
    case removeTracksForCurrentUser(ids: [String])
    case checkCurrentUserSavedAlbums(ids: [String])
    case checkUserSavedShows(ids: [String])
    case checkCurrentUserSavedTracks(ids: [String])
    case getCurrentUserSavedAlbums(limit: Int = 20, offset: Int = 0, market: String?)
    case getUserSavedShows(limit: Int = 20, offset: Int = 0)
    case getCurrentUserSavedTracks(limit: Int = 20, offset: Int = 0, market: String?)
    case saveAlbumsForCurrentUser(ids: [String])
    case saveShowsForCurrentUser(ids: [String])
    case saveTracksForCurrentUser(ids: [String])
    
    var method: HTTPMethod {
        switch self {
        case .removeUserSavedShows:
            return .delete
        case .removeAlbumsForCurrentUser:
            return .delete
        case .removeTracksForCurrentUser:
            return .delete
            
        case .checkUserSavedShows:
            return .get
        case .checkCurrentUserSavedAlbums:
            return .get
        case .checkCurrentUserSavedTracks:
            return .get
            
        case .getUserSavedShows:
            return .get
        case .getCurrentUserSavedAlbums:
            return .get
        case .getCurrentUserSavedTracks:
            return .get
            
        case .saveShowsForCurrentUser:
            return .put
        case .saveAlbumsForCurrentUser:
            return .put
        case .saveTracksForCurrentUser:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .removeUserSavedShows:
            return "/shows"
        case .removeAlbumsForCurrentUser:
            return "/albums"
        case .removeTracksForCurrentUser:
            return "/trakcs"
            
        case .checkUserSavedShows:
            return "/shows/contains"
        case .checkCurrentUserSavedAlbums:
            return "/albums/contains"
        case .checkCurrentUserSavedTracks:
            return "/tracks/contains"
            
        case .getUserSavedShows:
            return "/shows"
        case .getCurrentUserSavedAlbums:
            return "/albums"
        case .getCurrentUserSavedTracks:
            return "/tracks"
            
        case .saveShowsForCurrentUser:
            return "/shows"
        case .saveAlbumsForCurrentUser:
            return "/albums"
        case .saveTracksForCurrentUser:
            return "/tracks"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        
        case .removeAlbumsForCurrentUser(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .removeUserSavedShows(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .removeTracksForCurrentUser(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .checkCurrentUserSavedAlbums(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .checkUserSavedShows(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .checkCurrentUserSavedTracks(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .getCurrentUserSavedAlbums(limit: let limit, offset: let offset, market: let market):
            var parameters: Parameters = [:]
            
            parameters["limit"] = limit
            parameters["offset"] = offset
            
            if let market = market {
                parameters["market"] = market
            }
            
            return parameters
        case .getUserSavedShows(limit: let limit, offset: let offset):
            var parameters: Parameters = [:]
            
            parameters["limit"] = limit
            parameters["offset"] = offset
            
            return parameters
        case .getCurrentUserSavedTracks(limit: let limit, offset: let offset, market: let market):
                var parameters: Parameters = [:]
                
                parameters["limit"] = limit
                parameters["offset"] = offset
                
                if let market = market {
                    parameters["market"] = market
                }
                
                return parameters
        case .saveAlbumsForCurrentUser(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .saveShowsForCurrentUser(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .saveTracksForCurrentUser(ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: LibraryRouter.baseURL!.appendingPathComponent(path))
        
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
