//
//  LBCImageDownloaderTest.swift
//  TestLBCTests
//
//  Created by Aymen on 13/03/2021.
//

import XCTest
@testable import TestLBC

class LBCImageDownloaderTest: XCTestCase {

    func testDownloadImage() throws {
        
        let kPlaceHolderName = "lbc_placeholder"
        let placeHolderImage = UIImage(named: "lbc_placeholder")

        /**
                Downloading image from valid URL
         */
        
        //When downloading an image from a valid URL
        let validImageView = UIImageView()
        var downloadedImage: UIImage?
        let validImageUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/5ae4741dabd3a236cbfb8b6a5746acba6823e41e.jpg"

        let expectationDownloadValidImage = expectation(description: "Download image from valid URL ")
        validImageView.loadImageAsync(with: validImageUrl, placeHolder: kPlaceHolderName) { image in
            downloadedImage = image
            expectationDownloadValidImage.fulfill()

        }
       
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then the image must be not nil
        XCTAssertNotNil(downloadedImage, "The image must be non nil")
        
        //Can load the image from cache
        let imageFromCache = ImageCache.shared.image(forKey: validImageUrl)
        XCTAssertNotNil(imageFromCache, "The image must be non nil")

        //The downloaded image and the image in cache must be the same one
        XCTAssertEqual(imageFromCache, downloadedImage, "The downloaded image must be the same image loaded from the cache")
        
        //ImageView must display a placeHolder
        XCTAssertEqual(validImageView.image, downloadedImage, "The imageView must be displaying the loaded image")
        
        
        /**
                Try downloading image from invalid URL
         */
        
        //When downloading an image from an invalid URL
        let invalidImageView = UIImageView()
        var invalidImage: UIImage?
        let invalidImageUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/af9c43ff5a3b3692f9f1aa3c17d7b46d8b740311.jpg"
        let expectationInvalidImage = expectation(description: "Try to download image from an invalid URL")
        invalidImageView.loadImageAsync(with: invalidImageUrl, placeHolder: kPlaceHolderName) { image in
            invalidImage = image
            expectationInvalidImage.fulfill()

        }
        waitForExpectations(timeout: 5, handler: nil)
        
        //Then the image must be nil
        XCTAssertNil(invalidImage, "The image must be nil")
        
        //Cannot load an image from cache for the key 'invalidImageUrl'
        let invalidImageFromCache = ImageCache.shared.image(forKey: invalidImageUrl)
        XCTAssertNil(invalidImageFromCache, "The image must be nil")
        
        //ImageView must display a placeHolder
        XCTAssertEqual(invalidImageView.image, placeHolderImage, "The imageView must be displaying the given placeHolder")

    }
}
