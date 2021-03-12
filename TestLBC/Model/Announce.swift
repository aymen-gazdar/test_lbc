//
//  Announce.swift
//  TestLBC
//
//  Created by Aymen on 11/03/2021.
//

import Foundation

struct Announce: Codable {
    
    var id: Int
    var categoryId: Int
    var title: String
    var description: String
    var price: Double?
    var imagesUrl: ImageUrl
    var creationDate: String
    var isUrgent: Bool
    var siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryId   = "category_id"
        case title
        case description
        case price
        case imagesUrl    = "images_url"
        case creationDate = "creation_date"
        case isUrgent     = "is_urgent"
        case siret
    }
}

struct ImageUrl: Codable {
    var small: String?
    var thumb: String?
}
