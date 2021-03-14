//
//  LBCModelsTest.swift
//  TestLBCTests
//
//  Created by Aymen on 13/03/2021.
//

import XCTest
@testable import TestLBC

struct Requester<API: APIType>: NetworkRouter {
    
    private let kListingJsonName = "Listing"
    private let kCategoriesJsonName = "Categories"

    func request(_ route: API, completion: @escaping NetworkRouterCompletion) {
        
        var jsonMockFile = ""
        
        switch route.apiUrl {
        case LbcAPI.listing.apiUrl:
            jsonMockFile = kListingJsonName
            
        case LbcAPI.categories.apiUrl:
            jsonMockFile = kCategoriesJsonName
            
        default:
            break
        }
        
        if let mockData = self.loadDataMockFromFile(fileName: jsonMockFile) {
            completion(mockData, nil, nil)
            
        } else {
            completion(nil, nil, NetworkErrors.noData)

        }

    }
    
    func cancel() {
        print("Cancel request")
    }
    
    func loadDataMockFromFile(fileName: String) -> Data?{
        if let path = Bundle(for: LBCModelsTest.self).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
                
            } catch {
                print("Cannot load \(fileName) JSON")
            }
        }
        return nil
    }
    
}

class LBCModelsTest: XCTestCase {

    let requester = Requester<LbcAPI>()
    let networkDataHandler = NetworkDataHandler()

    func testAnnounceModelParse() throws {
        
        var mockedData: Data?

        let expectationAPICall = self.expectation(description: "testing Announces router API call from mocked json")

        requester.request(.listing) { (data, _, _) in
            mockedData = data
            
            // Fullfil the expectation to let the test runner
            expectationAPICall.fulfill()

        }
        
        // Wait for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 3, handler: nil)
        
        let unwrappedMockedData = try XCTUnwrap(mockedData, "unwrapping data if found")
        
        // decoding mocked data
        
        var mockedAnnounces: [Announce] = []

        let expectationDecode = self.expectation(description: "Testing decode mocked Announces")
        networkDataHandler.decode(unwrappedMockedData) { (annonces: [Announce]) in
            mockedAnnounces = annonces
            expectationDecode.fulfill()

        } failure: { (error) in
            
            //TODO: sometimes the Decoding fail, it's not systematic
                // in general only the fist unitTest's run fail
            
            XCTFail("Decoding announces data must succeed. But got error: \(error)")
            expectationDecode.fulfill()
        }
        
        // Wait for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 3, handler: nil)
              
        XCTAssertEqual(mockedAnnounces.count, 4, "MockedAnnounces array must contains 4 objects" )
        
        XCTAssertEqual(mockedAnnounces.first?.id, 1461267313 , "First Announce ID must be equal to 1461267313")
        XCTAssertEqual(mockedAnnounces.last?.id, 1077103477 , "Last Announce ID must be equal to 1077103477")

        
        XCTAssertEqual(mockedAnnounces.first?.categoryId, 4 , "First Announce's categoryID must be equal to 4")
        XCTAssertEqual(mockedAnnounces.last?.categoryId, 2 , "Last Announce's categoryID must be equal to 2")

        XCTAssertEqual(mockedAnnounces.first?.title, "Statue homme noir assis en plâtre polychrome" , "Announce's title must be 'Statue homme noir assis en plâtre polychrome'")
        XCTAssertEqual(mockedAnnounces.last?.title, "Ensemble fille 1 mois NEUF" , "Second Announce's title must be 'Ensemble fille 1 mois NEUF'")

        
        XCTAssertNotNil(mockedAnnounces.first?.creationDate, "First Announce's date must not be Nil")
        XCTAssertNotNil(mockedAnnounces.last?.creationDate, "Last Announce's date must not be Nil")
        
        // Test date string Format

        XCTAssertEqual(mockedAnnounces.first?.creationDate.stringDate, "05 Nov 2019 à 16:56 " , "First announce's date must be '05 Nov 2019 à 16:56'")
        XCTAssertEqual(mockedAnnounces.last?.creationDate.stringDate, "05 Nov 2019 à 16:56 " , "Last Announce's date must be '05 Nov 2019 à 16:56'")

        // Test currency formatter
        
        XCTAssertEqual(mockedAnnounces.first?.price?.euroFormat, "140,00 €" , "First announce's date must be '140,00 €'")
        XCTAssertEqual(mockedAnnounces.last?.price?.euroFormat, "5,00 €" , "Last Announce's date must be '5,00 €'")
        
    }
    
    func testCategoryModelParse() throws {
    
        var mockedData: Data?

        let expectationAPICall = self.expectation(description: "testing Categories router API call from mocked json")

        requester.request(.categories) { (data, _, _) in
            mockedData = data
            expectationAPICall.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        let unwrappedMockedData = try XCTUnwrap(mockedData, "unwrapping data if found")
        
        // decoding mocked data
        
        var mockedCategories: [TestLBC.Category]?
        
        let expectationDecode = self.expectation(description: "Testing decode mocked Category")
        networkDataHandler.decode(unwrappedMockedData) { (categories: [TestLBC.Category]) in
            mockedCategories = categories
            expectationDecode.fulfill()

        } failure: { error in
            XCTFail("Decoding categories data must succeed. But got error: \(error)")
            expectationDecode.fulfill()
        }
        
        // Wait for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 3, handler: nil)
        
        let unwrappedMockedCategories = try XCTUnwrap(mockedCategories, "unwrapping mocked categories")

        XCTAssertEqual(unwrappedMockedCategories.count, 11, "MockedCategories array must contains 11 categories" )
        
        XCTAssertEqual(unwrappedMockedCategories.first?.id, 1 , "First Category ID must be equal to 1")
        XCTAssertEqual(unwrappedMockedCategories.last?.id, 11 , "Second Category ID must be equal to 11")

        XCTAssertEqual(unwrappedMockedCategories.first?.name, "Véhicule" , "First Category name must be 'Véhicule'")
        XCTAssertEqual(unwrappedMockedCategories.last?.name, "Enfants" , "Second Category name must be 'Enfants'")
        
    }
    
    func testLbcApiUrl() throws {
        let listingUrl = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
        let categoriesUrl = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")
        
        XCTAssertEqual(LbcAPI.categories.apiUrl, categoriesUrl, "Category API Url is wrong")
        XCTAssertEqual(LbcAPI.listing.apiUrl, listingUrl, "Listing API Url is wrong")

    }
}
