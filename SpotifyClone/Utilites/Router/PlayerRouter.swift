//
//  PlayerRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum PlayerRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/me/player")
    
    case getTheCurrentUserRecentlyPlayedTracks(limit: Int = 20, after: String?, before: String?)
    case getInformationAboutTheUserCurrentPlayback(market: String?, additionalTypes: String?)
    case getAUserAvailableDevices(market: String, additionalTypes: String?)
    case getTheUserCurrentlyPlayingTracks(deviceId: String?)
    case skipUserPlaybackToNextTrack(deviceId: String?)
    case skipUserPlaybackToPreviousTrack(deviceId: String?)
    case addAnItemToTheEndOfTheUserCurrentPlaybackQueue(uri: String, deviceId: String?)
    case pauseAUserPlayback(deviceId: String?)
    case startResumeAUserPlayback(deviceId: String?)
    case setRepeatModeOnUserPlayback(state: String, deviceId: String?)
    case seekToPositionINCurrentlyPlayingTrack(positionMs: Int, deviceId: String?)
    case toggleShuffleForUserPlayback(state: String, deviceId: String?)
    case transfereAUserPlayback
    case setVolumeForUserPlayback(volumePercent: Int, deviceId: String?)
    
    var method: HTTPMethod {
        switch self {
        case .getTheCurrentUserRecentlyPlayedTracks:
            return .get
        case .getInformationAboutTheUserCurrentPlayback:
            return .get
        case .getAUserAvailableDevices:
            return .get
        case .getTheUserCurrentlyPlayingTracks:
            return .get
        case .skipUserPlaybackToNextTrack:
            return .post
        case .skipUserPlaybackToPreviousTrack:
            return .post
        case .addAnItemToTheEndOfTheUserCurrentPlaybackQueue:
            return .post
        case .pauseAUserPlayback:
            return .put
        case .startResumeAUserPlayback:
            return .put
        case .setRepeatModeOnUserPlayback:
            return .put
        case .seekToPositionINCurrentlyPlayingTrack:
            return .put
        case .toggleShuffleForUserPlayback:
            return .put
        case .transfereAUserPlayback:
            return .put
        case .setVolumeForUserPlayback:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .getTheCurrentUserRecentlyPlayedTracks:
            return "/recently-played"
        case .getInformationAboutTheUserCurrentPlayback:
            return "/"
        case .getAUserAvailableDevices:
            return "/devices"
        case .getTheUserCurrentlyPlayingTracks:
            return "/currenly-playing"
        case .skipUserPlaybackToNextTrack:
            return "/next"
        case .skipUserPlaybackToPreviousTrack:
            return "/prevoius"
        case .addAnItemToTheEndOfTheUserCurrentPlaybackQueue:
            return "/queue"
        case .pauseAUserPlayback:
            return "/pause"
        case .startResumeAUserPlayback:
            return "/play"
        case .setRepeatModeOnUserPlayback:
            return "/repeat"
        case .seekToPositionINCurrentlyPlayingTrack:
            return "/seek"
        case .toggleShuffleForUserPlayback:
            return "/shuffle"
        case .transfereAUserPlayback:
            return "/"
        case .setVolumeForUserPlayback:
            return "/volume"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getTheCurrentUserRecentlyPlayedTracks(limit: let limit, after: let after, before: let before):
            var parameters: Parameters = [:]
            
            parameters["limit"] = limit
            
            if let after = after {
                parameters["after"] = after
            }
            
            if let before = before {
                parameters["before"] = before
            }
            
            return parameters
        case .getInformationAboutTheUserCurrentPlayback(market: let market, additionalTypes: let additionalTypes):
            var parameters: Parameters = [:]
            
            
            if let market = market {
                parameters["market"] = market
            }
            
            if let additionalTypes = additionalTypes {
                parameters["additionalTypes"] = additionalTypes
            }
            
            return parameters
        case .getAUserAvailableDevices(market: let market, additionalTypes: let additionalTypes):
            var parameters: Parameters = [:]
            
            parameters["market"] = market
            
            if let additionalTypes = additionalTypes {
                parameters["additionalTypes"] = additionalTypes
            }
            
            return parameters
        case .getTheUserCurrentlyPlayingTracks(deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .skipUserPlaybackToNextTrack(deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .skipUserPlaybackToPreviousTrack(deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .addAnItemToTheEndOfTheUserCurrentPlaybackQueue(uri: let uri, deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            parameters["uri"] = uri
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .pauseAUserPlayback(deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .startResumeAUserPlayback(deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .setRepeatModeOnUserPlayback(state: let state, deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            parameters["state"] = state
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .seekToPositionINCurrentlyPlayingTrack(positionMs: let positionMs, deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            parameters["position_ms"] = positionMs
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .toggleShuffleForUserPlayback(state: let state, deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            parameters["state"] = state
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        case .transfereAUserPlayback:
            let parameters: Parameters = [:]
            
            return parameters
        case .setVolumeForUserPlayback(volumePercent: let volumePercent, deviceId: let deviceId):
            var parameters: Parameters = [:]
            
            parameters["volume_percent"] = volumePercent
            
            if let deviceId = deviceId {
                parameters["deviceId"] = deviceId
            }
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: PlayerRouter.baseURL!.appendingPathComponent(path))
        
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
