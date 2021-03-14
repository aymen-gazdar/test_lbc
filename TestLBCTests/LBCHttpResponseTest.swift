//
//  LBCHttpResponseTest.swift
//  TestLBCTests
//
//  Created by Aymen on 14/03/2021.
//

import XCTest
@testable import TestLBC

class LBCHttpResponseErrorTest: XCTestCase {

    func testHttpResponseError() throws {
        
        //Given
        let networkDataHandler = NetworkDataHandler()
        
        let httpResponse200 = HTTPURLResponse(url: URL(string: "https://www.validurl.fr")!,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: nil)!
        
        let httpResponse404 = HTTPURLResponse(url: URL(string: "https://www.invalidurl.fr")!,
                                             statusCode: 404,
                                             httpVersion: nil,
                                             headerFields: nil)!
        
        let httpResponse408 = HTTPURLResponse(url: URL(string: "https://www.timeouturl.fr")!,
                                             statusCode: 408,
                                             httpVersion: nil,
                                             headerFields: nil)!
        
        let httpResponse501 = HTTPURLResponse(url: URL(string: "https://www.badrequesturl.fr")!,
                                             statusCode: 501,
                                             httpVersion: nil,
                                             headerFields: nil)!
        
        let httpResponseunknown = HTTPURLResponse(url: URL(string: "https://www.unknownurl.fr")!,
                                             statusCode: 350,
                                             httpVersion: nil,
                                             headerFields: nil)!
        
        //When
        
        let networkResponse200 = networkDataHandler.handleNetworkResponse(httpResponse200)
        let networkResponse404 = networkDataHandler.handleNetworkResponse(httpResponse404)
        let networkResponse408 = networkDataHandler.handleNetworkResponse(httpResponse408)
        let networkResponse501 = networkDataHandler.handleNetworkResponse(httpResponse501)
        let networkResponseUnknown = networkDataHandler.handleNetworkResponse(httpResponseunknown)

        //Then

        switch networkResponse200 {
        case .success:
            break
        case .failure(let error):
            XCTFail("Must success but got error: \(error)")
        }
        
        switch networkResponse404 {
        case .success:
            XCTFail("Must return Failure")
            
        case .failure(let networkFailureError):
            XCTAssertEqual(networkFailureError.localizedDescription, NSLocalizedString("La ressource demandée n'est pas trouvée", comment: ""), "")
        }
        
        switch networkResponse408 {
        case .success:
            XCTFail("Must return Failure")
            
        case .failure(let networkFailureError):
            XCTAssertEqual(networkFailureError.localizedDescription, NSLocalizedString("Le délais de la requête a été dépassé", comment: ""), "")
        }
        
        switch networkResponse501 {
        case .success:
            XCTFail("Must return Failure")
            
        case .failure(let networkFailureError):
            XCTAssertEqual(networkFailureError.localizedDescription, NSLocalizedString("Un problème côté serveur est survenue lors de la récupération des données", comment: ""), "")
        }
        
        switch networkResponseUnknown {
        case .success:
            XCTFail("Must return Failure")
            
        case .failure(let networkFailureError):
            XCTAssertEqual(networkFailureError.localizedDescription, NSLocalizedString("Un problème est survenue lors de la récupération des données", comment: ""), "")
        }
    }
}
