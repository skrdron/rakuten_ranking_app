//
//  RankingForFemaleView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingForFemaleViewController: UIViewController {
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
                               if let ranking = notification.userInfo?[NotificationConst.rankingNotificationName] as? Ranking {
                                   self.items = ranking.items
                                   self.tableView.reloadData()
                               }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model = RankingModel(sex: .female, apiClient: DefaultAPIClient.shared)
        model.requestRanking()
    }
}

extension RankingForFemaleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingForFemaleCell", for: indexPath) as! RankingTableViewCell
        let item = items[indexPath.row].item
        tableView.rowHeight = 110
        
        cell.rankingLabel.text = "\(item.rank)"
        cell.productNameLabel.text = item.itemName
        cell.priceLabel.text = "¥\(item.itemPrice)"
        
        if let urlString = item.mediumImageUrls.first?.imageURL, let url = URL(string: urlString) {
            cell.productImageView.image = nil

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        if let currentIndexPath = tableView.indexPath(for: cell), currentIndexPath == indexPath {
                            cell.productImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
            task.resume()
          }
        
        return cell
    }
}

extension RankingForFemaleViewController: UITableViewDelegate {

}

