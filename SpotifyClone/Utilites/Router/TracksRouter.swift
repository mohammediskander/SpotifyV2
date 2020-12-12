//
//  Tracks.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum TracksRouter: Router {
    static var baseURL: URL?
    
//    case getAudioAnalysisForATrack(id: String)
//    case getAudioFeatuees
//    case getAudioFeaturesForATrack(id: String)
    
    case getSeveralTrack(ids: [String])
    case getTrack(id: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getSeveralTrack:
            return "/"
            
        case let .getTrack(id):
            return String(format: "/%@", id)
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .getSeveralTrack(ids):
            return ["ids": ids.joined(separator: ",")]
            
        case .getTrack:
            return nil
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: TracksRouter.baseURL!.appendingPathComponent(path))
        
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
