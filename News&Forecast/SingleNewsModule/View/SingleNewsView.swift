//
//  SingleNewsView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 17.11.2021.
//

import UIKit

class SingleNewsView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SingleNewsPresenterProtocol!
    var data: News?

    override func viewDidLoad() {
        tableView.register(UINib(nibName: "SingleNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        presenter.setNews()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
}

extension SingleNewsView: SingleNewsViewProtocol {
    func setNews(news: News?) {
        self.data = news
    }

}

extension SingleNewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SingleNewsTableViewCell
        guard let data = data else {return UITableViewCell()}
        cell.configure(data: data)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
}

extension SingleNewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

