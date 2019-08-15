//
//  ViewController.swift
//  some-art
//
//  Created by Leeann Drees on 8/13/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var artImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func artButtonTapped(_ sender: Any) {
        
        ArtNetworking.getArtwork(success: { (artData) in
            print(artData.count)
            guard let imageURLString = artData.artObjects.randomElement()?.webImage?.url else { return }
            guard let imageURL = URL(string: imageURLString) else { return }
            self.artImageView.load(url: imageURL)
        }) { (error) in
            print("oh no")
        }
        
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
