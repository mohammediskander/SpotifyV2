//
//  PersonalizationRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum PersonalizationRouter: Router {
    static var baseURL: URL? = URL(string: "\(Constants.SpotifyAPI.baseURL.rawValue)/me")
    
    case getUserTopArtitsAndTracks(type: String, timeRange: String?, limit: Int = 20, offset: Int = 0)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case let .getUserTopArtitsAndTracks(type, _, _, _):
            return String(format: "/top/%@", type)
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .getUserTopArtitsAndTracks(_, timeRange, limit, offset):
            var parameters: Parameters = [:]
            
            if let timeRange = timeRange {
                parameters["time_range"] = timeRange
            }
            
            parameters["limit"] = limit
            parameters["offset"] = offset
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: PersonalizationRouter.baseURL!.appendingPathComponent(path))
        
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
