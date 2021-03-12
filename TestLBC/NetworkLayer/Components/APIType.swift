//
//  APIType.swift
//  TestLBC
//
//  Created by Aymen on 10/03/2021.
//

import Foundation

/**
    main HTTP methods
 */

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    
}

protocol APIType {
    var apiUrl       : URL { get }
    var httpMethod   : HTTPMethod { get }
}
