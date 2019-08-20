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
    
    private lazy var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getArtObjectWithImage()
    }

    @IBAction func artButtonTapped(_ sender: Any) {
        viewModel.getArtObjectWithImage()
    }
    
}

extension ViewController: ViewModelDelegate {
    func updateImage() {
        guard let url = viewModel.url else { return }
        artImageView.load(url: url)
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
