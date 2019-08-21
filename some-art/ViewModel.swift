//
//  ViewModel.swift
//  some-art
//
//  Created by Leeann Drees on 8/15/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateImage()
}

extension ViewController {
    final class ViewModel {
        weak var delegate: ViewModelDelegate?
        public var url: URL? {
            didSet {
                delegate?.updateImage()
            }
        }
        
        var randomType: String {
            guard let randomCase = ArtType.allCases.randomElement()?.rawValue else { return ArtType.painting.rawValue }
            return randomCase
        }
        
        var randomTerm: String {
            guard let randomCase = SearchTerm.allCases.randomElement()?.rawValue else { return SearchTerm.cats.rawValue }
            return randomCase
        }
        
        func getArtObjectWithImage() {
            ArtNetworking.getArtwork(of: randomType, with: randomTerm, success: { (artData) in
                guard let randomObject = artData.artObjects.randomElement(),
                    let imageURL = URL(string:randomObject.webImage.url) else { return }
            
                self.url = imageURL
            }) { (error) in
                print("oh no")
            }
        }
    }
}
