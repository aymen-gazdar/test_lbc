//
//  API.swift
//  TestLBC
//
//  Created by Aymen on 10/03/2021.
//

import Foundation

public enum API : APIType {
    
    case listing
    case categories
    
    var apiUrl: URL {
        switch self {
        case .listing:
            guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
                fatalError("Listing URL could not be configured.")
            }
            return url
        case .categories:
            guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else {
                fatalError("Listing URL could not be configured.")
            }
            return url
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }

}
