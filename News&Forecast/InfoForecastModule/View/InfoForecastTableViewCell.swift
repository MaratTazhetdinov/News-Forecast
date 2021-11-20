//
//  InfoForecastTableViewCell.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 07.11.2021.
//

import UIKit

class InfoForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textLabel4: UILabel!
    @IBOutlet weak var textLabel5: UILabel!
    @IBOutlet weak var textLabel6: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: Weather) {
        textLabel1.text = "Min temperature: \(String(Int(data.main.tempMin))) °C"
        textLabel2.text = "Max temperature: \(String(Int(data.main.tempMax))) °C"
        textLabel3.text = "Feels like: \(String(Int(data.main.feelsLike))) °C"
        textLabel4.text = "Humidity: \(String(data.main.humidity)) %"
        textLabel5.text = "Pressure: \(String(data.main.pressure)) hPa"
        textLabel6.text = "Wind speed: \(String(data.wind.speed)) m/s"
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.backgroundView = blurEffectView
    }
}
