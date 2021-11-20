//
//  NewsTableViewCell.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 19.11.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(data: News) {
        titleLabel.text = data.title
    }


}
