//
//  PlaylistsRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum PlaylistsRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)")
    
    case removeItemsFromAPlaylist(playlistId: String)
    case getAListOfCurrentUserPlaylists(limit: Int = 20, offset: Int = 0)
    case getAPlaylistCoverImage(playlistId: String)
    case getAPlaylistItems(playlistId: String, market: String, fields: String?, limit: Int = 20, offset: Int = 0, additionalTypes: String?)
    case getAPlaylist(playlistId: String, market: String?, fields: String?, additionalTypes: String?)
    case getAListOfAUserPlaylists(userId: String, limit: Int = 20, offset: Int = 0)
    case addItemsToAPlaylist(playlistId: String, position: Int?, uris: [String])
    case createAPlaylist(userId: String)
    case uploadACustomPlaylistCoverImage(playlistId: String)
    case recoderOrReplaceAPlaylistItems(playlistId: String, uris: [String])
    case changeAPlaylistDetails(playlistId: String)
    
    var method: HTTPMethod {
        switch self {
        case .removeItemsFromAPlaylist:
            return .delete
        case .getAListOfCurrentUserPlaylists:
            return .get
        case .getAPlaylistCoverImage:
            return .get
        case .getAPlaylistItems:
            return .get
        case .getAPlaylist:
            return .get
        case .getAListOfAUserPlaylists:
            return .get
        case .addItemsToAPlaylist:
            return .post
        case .createAPlaylist:
            return .post
        case .uploadACustomPlaylistCoverImage:
            return .put
        case .recoderOrReplaceAPlaylistItems:
            return .put
        case .changeAPlaylistDetails:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .removeItemsFromAPlaylist(playlistId: let playlistId):
            return String(format: "/playlists/%@/tracks", playlistId)
        case .getAListOfCurrentUserPlaylists:
            return "/me/playlists"
        case .getAPlaylistCoverImage(playlistId: let playlistId):
            return String(format: "/playlists/%@/images", playlistId)
        case .getAPlaylistItems(playlistId: let playlistId, _, _, _, _, _):
            return String(format: "/playlists/%@/tracks", playlistId)
        case .getAPlaylist(playlistId: let playlistId, _, _, _):
            return String(format: "/playlists/%@", playlistId)
        case .getAListOfAUserPlaylists(userId: let userId, _, _):
            return String(format: "/users/%@/playlists", userId)
        case .addItemsToAPlaylist(playlistId: let playlistId, _, _):
            return String(format: "/playlists/%@/tracks", playlistId)
        case .createAPlaylist(userId: let userId):
            return String(format: "/users/%@/playlists", userId)
        case .uploadACustomPlaylistCoverImage(playlistId: let playlistId):
            return String(format: "/playlists/%@/images", playlistId)
        case .recoderOrReplaceAPlaylistItems(playlistId: let playlistId, _):
            return String(format: "/playlists/%@/tracks", playlistId)
        case .changeAPlaylistDetails(playlistId: let playlistId):
            return String(format: "/playlists/%@", playlistId)
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .removeItemsFromAPlaylist:
            return nil
        case .getAListOfCurrentUserPlaylists(limit: let limit, offset: let offset):
            return ["limit": limit, "offset": offset]
        case .getAPlaylistCoverImage:
            return nil
        case .getAPlaylistItems(_, market: let market, fields: let fields, limit: let limit, offset: let offset, additionalTypes: let additionalTypes):
            var parameter: Parameters = [:]
            
            parameter["market"] = market
            
            if let fields = fields {
                parameter["fields"] = fields
            }
            
            parameter["limit"] = limit
            parameter["offset"] = offset
            
            if let aadditionalTypes = additionalTypes {
                parameter["additional_types"] = additionalTypes
            }
            
            return parameter
        case .getAPlaylist(_, market: let market, fields: let fields, additionalTypes: let additionalTypes):
            var parameter: Parameters = [:]
            
            if let market = market {
                parameter["market"] = market
            }
                
            if let fields = fields {
                parameter["fields"] = fields
            }
            
            if let additionalTypes = additionalTypes {
                parameter["additinalTypes"] = additionalTypes
            }
            
            return parameter
        case .getAListOfAUserPlaylists(_, limit: let limit, offset: let offset):
            var parameter: Parameters = [:]
            
            parameter["limit"] = limit
            parameter["offset"] = offset
            
            return parameter
        case .addItemsToAPlaylist(_, position: let position, uris: let uris):
            var parameter: Parameters = [:]
            
            if let position = position {
                parameter["position"] = position
            }
            
            parameter["uris"] = uris.joined(separator: ",")
            
            return parameter
        case .createAPlaylist:
            return nil
        case .uploadACustomPlaylistCoverImage:
            return nil
        case .recoderOrReplaceAPlaylistItems(_, uris: let uris):
            var parameter: Parameters = [:]
            
            parameter["uris"] = uris.joined(separator: ",")
            
            return parameter
        case .changeAPlaylistDetails:
            return nil
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: PlaylistsRouter.baseURL!.appendingPathComponent(path))
        
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
