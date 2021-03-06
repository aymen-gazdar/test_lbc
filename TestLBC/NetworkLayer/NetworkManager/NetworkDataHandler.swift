//
//  NetworkDataHandler.swift
//  TestLBC
//
//  Created by Aymen on 11/03/2021.
//

import Foundation

enum Result<Error>{
    case success
    case failure(Error)
}

class NetworkDataHandler {
    
    /**
        handle url Response  data, error
     */
    
    func handleResponse(response: URLResponse? = nil,
                        data: Data?,
                        successCompletionBlock: (Data) -> Void,
                        failureCompletionBlock: (Error) -> Void){
        
        guard let response = response as? HTTPURLResponse else {
            failureCompletionBlock(NetworkErrors.unknown)
            return
        }
        guard let data = data else {
            failureCompletionBlock(NetworkErrors.noData)
            return
        }
        
        let result = self.handleNetworkResponse(response)
        switch result {
        case .success:
            successCompletionBlock(data)
            
        case .failure(let networkFailureError):
            failureCompletionBlock(networkFailureError)
        }
            
    }
    
    /**
        Check network error return Result<Error>
     */
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<Error>{
        switch response.statusCode {
        case 200...299:
            return .success
            
        case 404:
            return .failure(NetworkErrors.notFound)
            
        case 408:
            return .failure(NetworkErrors.timeOut)
            
        case 501...599:
            return .failure(NetworkErrors.badRequest)

        default:
            return .failure(NetworkErrors.unknown)
        }
    }
}

//MARK: Decoding response data

extension NetworkDataHandler {
    func decode<T>(_ data: Data,
                   success: ((T) -> Void),
                   failure: (Error) -> Void) where T : Decodable {
        do {
            let decoder = JSONDecoder()
            
            //Date fromatter
            decoder.dateDecodingStrategy = .formatted(DateFormatter.lbcDateFormatter)
            let decodedData = try decoder.decode(T.self, from: data)
            success(decodedData)
            
        } catch {
            Utils.log(log: error.localizedDescription)
            failure(NetworkErrors.noData)
        }
    }
}
