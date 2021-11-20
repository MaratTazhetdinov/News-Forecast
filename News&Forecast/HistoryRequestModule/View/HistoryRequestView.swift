//
//  HistoryRequestView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 08.11.2021.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class HistoryRequestView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HistoryRequestPresenterProtocol!
    var notificationToken: NotificationToken?
    var dataSource = BehaviorSubject<[History]>(value: [])
    let disposeBag = DisposeBag()
    
    var requests: [History] = [] {
        didSet {
              dataSource.onNext(requests)
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationToken = RealmManager.shared.getAllRequests().observe(on: .main, { change in
            switch change {
            case .initial(let collection):
                self.requests = collection.shuffled()
            default: break
            }
        })
        
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "HistoryTableViewCell", cellType: HistoryTableViewCell.self)) { index, model, cell in
            cell.initCell(by: model)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        }.disposed(by: self.disposeBag)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationToken?.invalidate()
        notificationToken = nil
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
}

extension HistoryRequestView: HistoryRequestViewProtocol {
    
}



