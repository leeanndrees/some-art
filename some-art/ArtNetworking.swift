//
//  ArtNetworking.swift
//  some-art
//
//  Created by Leeann Drees on 8/15/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

class ArtNetworking {
    
    static let artSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    static let artKey = <#String#>
    
    static func getArtwork(success: @escaping (ArtData) -> Void, failure: @escaping (Error) -> Void) {
        
        dataTask?.cancel()
        
        guard var urlComponents = URLComponents(string: "https://www.rijksmuseum.nl/api/en/collection") else { return }
        urlComponents.query = "key=MAV5IXPH&format=json&type=painting&q=cats"
            
        guard let url = urlComponents.url else { return }
        
        dataTask = artSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                failure(error)
                print("failure")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                print(data)
                guard let newArtData = self.converted(from: data) else { return }
                success(newArtData)
                print(newArtData)
            }
            
        }
        
        dataTask?.resume()
    }
    
    static private func converted(from data: Data) -> ArtData? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ArtData.self, from: data)
            return response
        } catch {
            return nil // TODO: add error handling
        }
    }
}
