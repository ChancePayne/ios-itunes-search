//
//  ResultType.swift
//  iTunesSearch
//
//  Created by Chance Payne on 10/5/19.
//  Copyright © 2019 Chance Payne. All rights reserved.
//

import Foundation

/*enum ResultType: String {
    case software
    case musicTrack
    case movie
}*/

struct ResultType {
    static let types = [
        "Apps": "software",
        "Movies": "movie",
        "Music": "musicTrack"
    ]
}
