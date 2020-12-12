//
//  BrowseRouter.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

enum BrowserRouter: Router {
    static var baseURL: URL? = URL(string: Constants.SpotifyAPI.baseURL.rawValue)
    
    case getAvaliableGenreSeeds
    case getAListOfBrowseCategories(country: String?, locale: String?, limit: Int = 20, offset: Int = 0)
    case getASingleBrowseCategory(categoryId: String, country: String?, locale: String?)
    case getACategoryPlayLists(categoryId: String, country: String?, limit: Int = 20, offset: Int = 0)
    
    // timestamp example: 2014-10-23T09:00:00
    case getAListOfFeaturedPlaylists(country: String?, locale: String?, timestamp: Date?, limit: Int = 20, offset: Int = 0)
    case getAListOfNewReleases(country: String?, limit: Int = 20, offset: Int = 0)
    case getRecommendationsBasedOnSeeds(limit: Int = 20, market: String?, seedArtits: String, seedGenres: String, seedTracks: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getAvaliableGenreSeeds:
            return "/recommendations/available-genre-seeds"
        case .getAListOfBrowseCategories:
            return "/browse/categories"
        case let .getASingleBrowseCategory(categoryId, _, _):
            return String(format: "/browse/categories/%@", categoryId)
        case let .getACategoryPlayLists(categoryId, _, _, _):
            return String(format: "/browse/categories/%@/playlists", categoryId)
        case .getAListOfFeaturedPlaylists:
            return "/browse/featured-playlists"
        case .getAListOfNewReleases:
            return "/browse/new-releases"
        case .getRecommendationsBasedOnSeeds:
            return "/recommendations"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAvaliableGenreSeeds:
            let parameters: Parameters = [:]
            
            return parameters
        case let .getAListOfBrowseCategories(country, locale, limit, offset):
            var parameters: Parameters = [:]
            
            if let country = country {
                parameters["country"] = country
            }
            
            if let locale = locale {
                parameters["locale"] = locale
            }
            
            parameters["limit"] = limit
            
            parameters["offset"] = offset
            
            return parameters
        case let .getASingleBrowseCategory(_, country, locale):
            var parameters: Parameters = [:]
            
            if let country = country {
                parameters["country"] = country
            }
            
            if let locale = locale {
                parameters["locale"] = locale
            }
            
            return parameters
        case let .getACategoryPlayLists(_, country, limit, offset):
            var parameters: Parameters = [:]
            
            if let country = country {
                parameters["country"] = country
            }
            
            parameters["limit"] = limit
            
            parameters["offset"] = offset
            
            return parameters
        case let .getAListOfFeaturedPlaylists(country, locale, timestamp, limit, offset):
            var parameters: Parameters = [:]
            
            if let country = country {
                parameters["country"] = country
            }
            
            if let locale = locale {
                parameters["locale"] = locale
            }
            
            if let timestamp = timestamp {
                var dateFormatter: DateFormatter {
                    let dFormatter = DateFormatter()
                    // 2014-10-23T09:00:00
                    dFormatter.dateFormat = "yyyy-MM-dd`T`HH:mm:ss"
                    dFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    
                    return dFormatter
                }
                
                parameters["timestamp"] = dateFormatter.string(from: timestamp)
            }
            
            parameters["limit"] = limit
            
            parameters["offset"] = offset
            
            return parameters
        case let .getAListOfNewReleases(country, limit, offset):
            var parameters: Parameters = [:]
            
            if let country = country {
                parameters["country"] = country
            }
            
            parameters["limit"] = limit
            
            parameters["offset"] = offset
            
            return parameters
        case let .getRecommendationsBasedOnSeeds(limit, market, seedArtits, seedGenres, seedTracks):
            var parameters: Parameters = [:]
            
            if let market = market {
                parameters["market"] = market
            }
            
            parameters["seedArtits"] = seedArtits
            
            parameters["seedGenres"] = seedGenres
            
            parameters["seedTracks"] = seedTracks
            
            parameters["limit"] = limit
            
            
            return parameters
        }
    }
    
    var accessType: AccessType? {
        return .privateRoute
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: BrowserRouter.baseURL!.appendingPathComponent(path))
        
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
