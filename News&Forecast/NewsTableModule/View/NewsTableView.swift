//
//  NewsTableView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 14.11.2021.
//

import UIKit

class NewsTableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: NewsTablePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.isNavigationBarHidden = true
    }
}

extension NewsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        if let news = presenter.news {
            cell.configure(data: news[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}

extension NewsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleNews = presenter.news?[indexPath.row]
        presenter.tapOnTheNews(news: singleNews)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsTableView : NewsTableViewProtocol {
    func success() {
        if tableView != nil {
            tableView.reloadData()
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
