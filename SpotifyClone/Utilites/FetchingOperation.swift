//
//  FetchingOperation.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

class FetchingOperation<T>: Operation {
    var endpoint: Router?
    let completion: Fetcher<T>.ResultHandler
    
//    typealias ImageResult = Result<UIImage, Error>
    
    init(endpoint: Router, priority: Fetcher<T>.Priority = .low, completion: @escaping Fetcher<T>.ResultHandler) {
        self.endpoint = endpoint
        self.completion = completion
        
        super.init()
        
        switch priority {
        case .high:
            qualityOfService = .userInitiated
            queuePriority = .high
        case .low:
            qualityOfService = .utility
            queuePriority = .low
        }
    }
    
    convenience init(operation: FetchingOperation<T>, priority: Fetcher<T>.Priority = .low) {
        guard let endpoint = operation.endpoint else {
            preconditionFailure("FETAL: Attempt to clone an operation with nil url.")
        }
        
        self.init(endpoint: endpoint, priority: priority, completion: operation.completion)
    }
    
    override func cancel() {
        super.cancel()
        endpoint = nil
    }
    
    override func main() {
        guard let endpoint = endpoint else {
            completion(.failure(Fetcher<T>.Error.canceled))
            return
        }
        
        do {
//            try self.fetch(url) { [weak self]
//                result in
//
//                guard let self = self else { return }
//
//                switch result {
//                case let .success(image):
//                    self.completion(.success(image))
//                case let .failure(error):
//                    self.completion(.failure(error))
//                }
//            }
            
            
        } catch {
            completion(.failure(error))
        }
    }
    
//    func fetch(_ url: URL, completion: @escaping (Fethcer<T>.FetcherResult) -> Void) throws {
//        guard !isCancelled else { throw Fetcher<T>.Error.canceled }
//
//        // Set up the URLRequest and Session
//        let session: URLSession = {
//            let config = URLSessionConfiguration.default
//            return URLSession(configuration: config)
//        }()
//        let request = URLRequest(url: url)
//
//        session.dataTask(with: request) {
//            [weak self] data, response, error in
//
//            guard let self = self else { return }
//
//            let result = self.parseImage(data: data, error: error)
//
//            completion(result)
//        }.resume()
//    }
//
//    func parseImage(data: Data?, error: Error?) -> ImageResult {
//        guard let imageData = data, let image = UIImage(data: imageData) else {
//            if data == nil {
//                return .failure(error!)
//            } else {
//                return .failure(PhotoError.imageCreationError)
//            }
//        }
//
//        return .success(image)
//    }
}
