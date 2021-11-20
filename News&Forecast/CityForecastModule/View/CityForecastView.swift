//
//  CityForecastView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import UIKit

class CityForecastView: UIViewController {

    var presenter: CityForecastPresenterProtocol!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }

    @IBAction func backButtonTap(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    @IBAction func goButtonTap(_ sender: Any) {
        if let city = textField.text {
            self.presenter?.selectCity(city)
        }
    }
    
    @IBAction func historyButtonTap(_ sender: Any) {
        self.presenter?.presentHistoryRequest()
    }
}

extension CityForecastView: CityForecastViewProtocol {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CityForecastView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        if let city = textField.text {
//            self.presenter?.selectCity(city)
//        }
        return true
    }
}
