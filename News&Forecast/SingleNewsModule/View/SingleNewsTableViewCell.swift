//
//  SingleNewsTableViewCell.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 20.11.2021.
//

import UIKit

class SingleNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(data: News) {
        titleLabel.text = data.title
        DescriptionLabel.text = data.description
    }
    
}
