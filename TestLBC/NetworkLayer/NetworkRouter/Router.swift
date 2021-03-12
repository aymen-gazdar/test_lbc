//
//  Router.swift
//  TestLBC
//
//  Created by Aymen on 10/03/2021.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,
                                            _ response: URLResponse?,
                                            _ error: Error?) -> Void

protocol NetworkRouter {
    associatedtype API: APIType
    
    func request(_ route: API,
                 completion: @escaping NetworkRouterCompletion)
    
    func cancel()
    
}

class Router<API: APIType>: NSObject,
                            NetworkRouter,
                            URLSessionTaskDelegate {
              
    //MARK: var
    
    private var task: URLSessionTask?
    
    //MARK: Methods
    
    /**
        requester to pass throught api calls
     */
    
    func request(_ route: API, completion: @escaping NetworkRouterCompletion) {
        
        var request = URLRequest(url: route.apiUrl,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        self.task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        
        self.task?.resume()
    }
    
    /**
        cancel an api call
     */
    
    func cancel() {
        self.task?.cancel()
    }
}
