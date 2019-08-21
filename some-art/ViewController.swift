//
//  ViewController.swift
//  some-art
//
//  Created by Leeann Drees on 8/13/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var contentScrollView: UIScrollView!
    @IBOutlet var artImageView: UIImageView!
    
    private lazy var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getArtObjectWithImage()
        contentScrollView.alwaysBounceVertical = true
        configureRefreshControl()
    }

    func configureRefreshControl() {
        contentScrollView.refreshControl = UIRefreshControl()
        contentScrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        viewModel.getArtObjectWithImage()
        
        DispatchQueue.main.async {
            self.contentScrollView.refreshControl?.endRefreshing()
        }
    }
    
}

extension ViewController: ViewModelDelegate {
    func updateImage() {
        guard let url = viewModel.url else { return }
        artImageView.load(url: url)
    }
}
