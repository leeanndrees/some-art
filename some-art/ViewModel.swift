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
    class ViewModel {
        
        weak var delegate: ViewModelDelegate?
        public var url: URL? {
            didSet {
                delegate?.updateImage()
            }
        }
        
        func getArtObjectWithImage() {
            ArtNetworking.getArtwork(success: { (artData) in
                guard let randomObject = artData.artObjects.randomElement() else { return }
                guard let imageURL = URL(string:randomObject.webImage.url) else { return }
                self.url = imageURL
            }) { (error) in
                print("oh no")
            }
        }
    }
}
