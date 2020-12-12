//
//  FetchingRequest.swift
//  SpotifyClone
//
//  Created by Mohammed Iskandar on 12/12/2020.
//

import Foundation

class FetchingRequest<T> {
    private var operation: FetchingOperation<T>
    private let queue: OperationQueue
    
    var priority: Fetcher<T>.Priority = .low {
        didSet(oldPriority) {
            guard priority != oldPriority else { return }
            guard !operation.isExecuting else { return }
            
            let newOperation = FetchingOperation<T>(operation: operation, priority: priority)
            
            operation.cancel()
            operation = newOperation
            queue.addOperation(newOperation)
        }
    }
    
    init(operation: FetchingOperation<T>, queue: OperationQueue) {
        self.operation = operation
        self.queue = queue
    }
    
    func cancel() {
        operation.cancel()
    }
}
