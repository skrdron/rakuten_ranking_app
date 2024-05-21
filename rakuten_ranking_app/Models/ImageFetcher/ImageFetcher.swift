//
//  ImageFetcher.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/21.
//

import Foundation
import UIKit

class ImageFetcher {
    static func fetchImage(for cell: UITableViewCell, at indexPath: IndexPath, from urlString: String, in tableView: UITableView) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if let currentIndexPath = tableView.indexPath(for: cell), currentIndexPath == indexPath {
                    (cell as? RankingTableViewCell)?.productImageView.image = UIImage(data: data)
                }
            }
        }
        
        task.resume()
    }
}
