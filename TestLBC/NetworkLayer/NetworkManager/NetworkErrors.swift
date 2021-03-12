//
//  NetworkErrors.swift
//  TestLBC
//
//  Created by Aymen on 12/03/2021.
//

import Foundation

enum NetworkErrors: Error {
    case notFound
    case noData
    case timeOut
    case badRequest
    case unknown
}

extension NetworkErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("La ressource demandée n'est pas trouvée", comment: "")
        
        case .noData:
            return NSLocalizedString("Un problème est survenue lors de traitement des données", comment: "")
            
        case .timeOut:
            return NSLocalizedString("Le délais de la requête a été dépassé", comment: "")
        
        case .badRequest:
            return NSLocalizedString("Un problème côté serveur est survenue lors de la récupération des données", comment: "")
            
        default:
            return NSLocalizedString("Un problème est survenue lors de la récupération des données", comment: "")
        }
    }
}
