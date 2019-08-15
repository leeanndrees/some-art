//
//  ArtData.swift
//  some-art
//
//  Created by Leeann Drees on 8/15/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct ArtData: Decodable {
    let count: Int
    let artObjects: [ArtObject]
}

struct ArtObject: Decodable {
    let title: String
    let webImage: WebImage?
}

struct WebImage: Decodable {
    let url: String
}
