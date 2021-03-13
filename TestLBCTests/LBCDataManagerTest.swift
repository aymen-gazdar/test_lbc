//
//  LBCDataManagerTest.swift
//  TestLBCTests
//
//  Created by Aymen on 13/03/2021.
//

import XCTest
@testable import TestLBC

class LBCDataManagerTest: XCTestCase {

    private let kListingJsonName = "Listing"
    private let networkDataHandler = NetworkDataHandler()
    private let announcesInteractor = AnnouncesInteractor()
    
    func testDataSorting() throws {
        
        let announcesData = try Data(contentsOf: URL(fileURLWithPath: Bundle(for: LBCDataManagerTest.self).path(forResource: kListingJsonName, ofType: "json") ?? ""), options: .mappedIfSafe)
        
        var announces: [Announce]?
        
        let expectationDecode = self.expectation(description: "Decoding...")
        networkDataHandler.decode(announcesData) { (annonces: [Announce]) in
            announces = annonces
            expectationDecode.fulfill()

        } failure: { (error) in
            XCTFail("Decoding announces data must succeed. But got error: \(error)")
            expectationDecode.fulfill()
        }
        // Wait for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 3, handler: nil)
        
        /**
            Test Sorting announces
         */
        
        // check isUrgent attribute before Sorting
        
        let unwrappedAnnounces = try XCTUnwrap(announces)
        let firstAnnounce = try XCTUnwrap(unwrappedAnnounces.first?.isUrgent, "unwrapping first announce")
        let secondAnnounce = try XCTUnwrap(unwrappedAnnounces[1].isUrgent, "unwrapping second announce")

        XCTAssertFalse(firstAnnounce, "The first announce must be not an urgent announce")
        XCTAssertTrue(secondAnnounce, "The second announce must be an urgent announce")
        
        
        // Sorting
        
        let sortedAnnounces = announces?.sorted()
        let unwrappedSortedAnnounces = try XCTUnwrap(sortedAnnounces)

        
        // check isUrgent attribute after Sorting

        let unwrappedFirstAnnounceUrgent = try XCTUnwrap(unwrappedSortedAnnounces.first?.isUrgent, "unwrapping first announce urgent")
        let unwrappedSecondAnnounceUrgent = try XCTUnwrap(unwrappedSortedAnnounces[1].isUrgent, "unwrapping second announce urgent")

        XCTAssertTrue(unwrappedFirstAnnounceUrgent, "The first announce must be an urgent announce")
        XCTAssertTrue(unwrappedSecondAnnounceUrgent, "The second announce must be an urgent announce")
        
        let unwrappedThirdAnnounceDate = try XCTUnwrap(unwrappedSortedAnnounces[2].creationDate, "unwrapping third announce date")
        let unwrappedFourthAnnounceDate = try XCTUnwrap(unwrappedSortedAnnounces[3].creationDate, "unwrapping fourth announce date")
        
        XCTAssertLessThan(unwrappedThirdAnnounceDate, unwrappedFourthAnnounceDate, "ThirdAnnounceDate date must be before the FourthAnnounceDate")
        
    }
    
    func testAssociateCategoriesToAnnouces() throws {
        let announcesInteractor = AnnouncesInteractor()
        
        let categories = [Category(id: 1, name: "Véhicule"),
                          Category(id: 2, name: "Informatique")]
        
        let announces = [Announce(id: 123, categoryId: 2, category: nil, title: "Carte         graphique", description: "Carte graphique pour PC Dell", price: 100, imagesUrl: ImageUrl(small: "www.imageSmall.fr", thumb: "www.imageThumb.fr"), creationDate: Date(), isUrgent: false, siret: nil),
                         Announce(id: 456, categoryId: 1, category: nil, title: "Jante alliage Ford", description: "Jante alliage 19 pouces pour Ford Focus", price: 200, imagesUrl: ImageUrl(small: "www.imageSmall.fr", thumb: "www.imageThumb.fr"), creationDate: Date(), isUrgent: false, siret: nil) ]
        
        let expectationDecode = self.expectation(description: "Returned announces must be associated with their categories...")
        
        var assocAnnounces: [Announce]?
        announcesInteractor.associateCategories(categories, with: announces) { (announcesWithCategories) in
            assocAnnounces = announcesWithCategories
            expectationDecode.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        let unwrappedAssocAnnounces = try XCTUnwrap(assocAnnounces)
        
        let unwrappedFirstAnnounceCateg = try XCTUnwrap(unwrappedAssocAnnounces.first?.category)
        let unwrappedSecondAnnounceCateg = try XCTUnwrap(unwrappedAssocAnnounces.last?.category)

        XCTAssertEqual(unwrappedFirstAnnounceCateg.id, 2, "CategoryId must be 2")
        XCTAssertEqual(unwrappedSecondAnnounceCateg.id, 1, "CategoryId must be 1")

    }
}
