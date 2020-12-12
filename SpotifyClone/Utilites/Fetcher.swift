//
//  Fetcher.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

class Fetcher<T> {
    
    enum Error: Swift.Error {
        case canceled
    }
    
    enum Priority {
        case high
        case low
    }
    
    typealias FetcherResult = Result<T, Swift.Error>
    typealias ResultHandler = (FetcherResult) -> Void
    
    
    var maxConcurrentOperationCount: Int!
    
    init(maxConcurrentOperationCount: Int = 3) {
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
    private lazy var fetchingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = self.maxConcurrentOperationCount
        return queue
    }()
    
    @discardableResult
    func fetch(_ endpoint: Router, priority: Fetcher<T>.Priority, completion: @escaping ResultHandler) -> FetchingRequest<T> {
        let imageOperation = FetchingOperation<T>(endpoint: endpoint, priority: priority, completion: completion)
        let request = FetchingRequest<T>(operation: imageOperation, queue: fetchingQueue)
        
        return request
    }
}
