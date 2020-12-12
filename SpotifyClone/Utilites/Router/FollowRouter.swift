//
//  FollowRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum FollowRouter: Router {
    static var baseURL: URL? = URL(string: Constants.SpotifyAPI.baseURL.rawValue)
    
    case unfollowArtistsOrUsers(type: String, ids: [String])
    case unfollowAPlayList(playListId: String)
    case checkIfCurrentUserFollowsArtitsOfUser(type: String, ids: [String])
    case getFollowedArtists(type: String, after: String?, limit: Int = 20)
    case checkIfUserFollowAPlaylist(playListId: String, ids: [String])
    case followArtitsOrUser(type: String, ids: [String])
    case followPlayList(playListId: String)
    
    var method: HTTPMethod {
        switch self {
        case .unfollowArtistsOrUsers:
            return .delete
        case .unfollowAPlayList:
            return .delete
            
        case .checkIfCurrentUserFollowsArtitsOfUser:
            return .get
        case .getFollowedArtists:
            return .get
        case .checkIfUserFollowAPlaylist:
            return .get
            
        case .followArtitsOrUser:
            return .put
        case .followPlayList:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .unfollowArtistsOrUsers:
            return "/me/following"
        case let .unfollowAPlayList(playListId):
            return String(format: "/playlists/%@/followers", playListId)
            
        case .checkIfCurrentUserFollowsArtitsOfUser:
            return "/me/following/contains"
        case .getFollowedArtists:
            return "/me/following"
        case let .checkIfUserFollowAPlaylist(playListId, _):
            return String(format: "/playlists/%@/followers/contains", playListId)
            
        case .followArtitsOrUser:
            return "/me/following"
        case let .followPlayList(playListId):
            return String(format: "/playlists/%@/followers", playListId)
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .unfollowArtistsOrUsers(type: let type, ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["type"] = type
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
            
        case .unfollowAPlayList:
            let parameters: Parameters = [:]
            
            return parameters
        case .checkIfCurrentUserFollowsArtitsOfUser(type: let type, ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["type"] = type
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .getFollowedArtists(type: let type, after: let after, limit: let limit):
            var parameters: Parameters = [:]
            
            parameters["type"] = type
            parameters["limit"] = limit
            
            if let after = after {
                parameters["after"] = after
            }
            return parameters
        case .checkIfUserFollowAPlaylist(_, ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .followArtitsOrUser(type: let type, ids: let ids):
            var parameters: Parameters = [:]
            
            parameters["type"] = type
            parameters["ids"] = ids.joined(separator: ",")
            
            return parameters
        case .followPlayList:
            let parameters: Parameters = [:]
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: FollowRouter.baseURL!.appendingPathComponent(path))
        
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
