//
//  HistoryTableViewCell.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 08.11.2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func initCell(by request: History) {
        cityLabel.text = request.city
        temperatureLabel.text = request.result
        dateLabel.text = String(request.date)
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.backgroundView = blurEffectView
    }
}
