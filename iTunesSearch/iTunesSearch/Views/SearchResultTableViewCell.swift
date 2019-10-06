//
//  SearchResultTableViewCell.swift
//  iTunesSearch
//
//  Created by Chance Payne on 10/5/19.
//  Copyright © 2019 Chance Payne. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var searchResult: SearchResultItem? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let searchResult = searchResult else { return }
        
        titleLabel.text = searchResult.title
        subtitleLabel.text = searchResult.creator
    }
}
