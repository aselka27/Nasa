//
//  ResultImage.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import Foundation


struct ResultImage: Decodable {
    let urls: [URL]
    
    init(from decoder: Decoder) throws {
        let stringArray = try decoder.singleValueContainer().decode([String].self)
        urls = stringArray.compactMap { URL(string: $0) }
    }
}
