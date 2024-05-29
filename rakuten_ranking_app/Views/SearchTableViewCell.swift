//
//  SearchTableViewCell.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/28.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    func configure(with item: SearchItem, at indexPath: IndexPath, in tableView: UITableView) {
        productNameLabel.text = item.itemName
        priceLabel.text = PriceFormatter.formatPrice(String(item.itemPrice))
        productImageView.image = nil
        
        if let urlString = item.mediumImageUrls.first?.imageUrl {
          ImageFetcher.fetchImage(from: urlString) { [weak self] image in
              DispatchQueue.main.async {
                 self?.productImageView.image = image
              }
          }
        }
    }
}
