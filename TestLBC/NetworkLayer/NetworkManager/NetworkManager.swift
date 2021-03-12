//
//  NetworkManager.swift
//  TestLBC
//
//  Created by Aymen on 10/03/2021.
//

import Foundation

class NetworkManager {
    
    //MARK: let var

    static let shared = NetworkManager()
    
    let networkDataHandler = NetworkDataHandler()
    
    let router = Router<API>()
    
    //MARK: let var

    func listing(successCompletionBlock: @escaping ([Announce]) -> Void,
                 failureCompletionBlock: @escaping (Error) -> Void) {
        
        router.request(.listing) { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                failureCompletionBlock(NetworkErrors.unknown)
                return
            }
            
            if error != nil {
                failureCompletionBlock(NetworkErrors.unknown)
            }

            strongSelf.networkDataHandler.handleResponse(response: response, data: data, successCompletionBlock: { data in
                
                strongSelf.networkDataHandler.decode(data) { (annonces: [Announce]) in
                    successCompletionBlock(annonces)
                    
                } failure: { _ in
                    failureCompletionBlock(NetworkErrors.noData)
                    
                }

            }, failureCompletionBlock: { error in
                failureCompletionBlock(error)

            })
        }
    }
    
    func categories(successCompletionBlock: @escaping ([Category]) -> Void,
                 failureCompletionBlock: @escaping (Error) -> Void) {
        
        router.request(.categories) { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                failureCompletionBlock(NetworkErrors.unknown)
                return
            }
            
            if error != nil {
                failureCompletionBlock(NetworkErrors.unknown)
            }

            strongSelf.networkDataHandler.handleResponse(response: response, data: data, successCompletionBlock: { data in
                
                strongSelf.networkDataHandler.decode(data) { (categories: [Category]) in
                    successCompletionBlock(categories)
                    
                } failure: { _ in
                    failureCompletionBlock(NetworkErrors.noData)
                    
                }

            }, failureCompletionBlock: { error in
                failureCompletionBlock(error)

            })
        }
    }
    
}

