//
//  RankingForMaleView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingForMaleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var model: RankingModel! {
      didSet {
        registerModel()
      }
    }
    
    private var items: [ItemElement] = []
    
    deinit {
      model.notificationCenter.removeObserver(self)
    }
    
    private func registerModel() {
      _ = model.notificationCenter
            .addObserver(forName: .init(rawValue: NotificationConst.rankingNotificationName),
                            object: nil, queue: nil) { notification in
                               guard let sexType = notification.userInfo?["sexType"] as? RankingModel.SexType,
                                     sexType == .male,
                                     let ranking = notification.userInfo?[NotificationConst.rankingNotificationName] as? Ranking else {
                                 return
                               }
                               self.items = ranking.items
                               self.tableView.reloadData()
                            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        model = RankingModel(sex: .male, apiClient: DefaultAPIClient.shared)
        model.requestRanking()
    }
}


extension RankingForMaleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingForMaleCell", for: indexPath) as! RankingTableViewCell
        let item = items[indexPath.row].item
          
        cell.configure(with: item, at: indexPath, in: tableView)
          
        return cell
    }
}

extension RankingForMaleViewController: UITableViewDelegate {
}
