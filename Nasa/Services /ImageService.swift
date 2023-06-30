//
//  ImageService.swift
//  Nasa
//
//  Created by саргашкаева on 29.06.2023.
//

import UIKit



protocol ImageService {
    
}


class ImageServiceImpl: ImageService {
    static let shared = ImageServiceImpl()
    
    private init() {}
    
    func getEventImageFor(url: String ) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return UIImage(data: data)
    }
}
