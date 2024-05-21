//
//  RankingTableViewCell.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/17.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    
    func configure(with item: Item, at indexPath: IndexPath, in tableView: UITableView) {
        rankingLabel.text = "\(item.rank)"
        productNameLabel.text = item.itemName
        priceLabel.text = PriceFormatter.formatPrice(item.itemPrice)
        productImageView.image = nil
          
        if let urlString = item.mediumImageUrls.first?.imageURL {
          ImageFetcher.fetchImage(for: self, at: indexPath, from: urlString, in: tableView)
        }
    }
}

