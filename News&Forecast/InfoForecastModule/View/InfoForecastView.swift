//
//  InfoForecastView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 06.11.2021.
//

import UIKit

class InfoForecastView: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherCondLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var presenter: InfoForecastPresenterProtocol!
    var weatherAttributes: Weather?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.setWeather()
        guard let data = weatherAttributes else {return}
        
        switch data.weather[0].main {
        case "Clouds":
            backgroundImage.image = UIImage(named: "clouds")
        case "Thunderstorm":
            backgroundImage.image = UIImage(named: "thunderstorm")
        case "Drizzle":
            backgroundImage.image = UIImage(named: "drizzle")
        case "Rain":
            backgroundImage.image = UIImage(named: "rain")
        case "Snow":
            backgroundImage.image = UIImage(named: "snow")
        case "Clear":
            backgroundImage.image = UIImage(named: "clear")
        default:
            backgroundImage.image = UIImage(named: "other")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "InfoForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidLayoutSubviews() {
        tableView.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
}

extension InfoForecastView: InfoForecastViewProtocol {
    func setWeather(_ weather: Weather?) {
        if let data = weather {
            cityLabel.text = data.name
            temperatureLabel.text = "\(String(Int(data.main.temp))) °C"
            weatherCondLabel.text = data.weather[0].main
            weatherAttributes = data
            tableView.reloadData()
        }
    }
}

extension InfoForecastView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InfoForecastTableViewCell
        guard let data = weatherAttributes else {return UITableViewCell()}
        cell.configure(data: data)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

extension InfoForecastView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
