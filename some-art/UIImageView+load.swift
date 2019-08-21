//
//  UIImageView+load.swift
//  some-art
//
//  Created by Leeann Drees on 8/20/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
}
