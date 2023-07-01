//
//  SearchResult.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


struct SearchResult: Codable {
    let collection: Collection?
}

struct Collection: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let data: [ItemDetail]?
    let links: [Link]?
}

struct ItemDetail: Codable {
    let id: String?
    let title: String?
    let dateCreated: String?
    let description: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title, description
        case dateCreated = "date_created"
        case id = "nasa_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}

struct Link: Codable {
    let href: String?
}

