//
//  SearchTableViewCell.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/28.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(with item: SearchItem, at indexPath: IndexPath, in tableView: UITableView) {
          productNameLabel.text = item.itemName
          priceLabel.text = PriceFormatter.formatPrice(String(item.itemPrice))
          ImageFetcher.fetchImage(from: item.mediumImageUrls.first?.imageUrl ?? "") { [weak self] image in
              DispatchQueue.main.async {
                  if tableView.cellForRow(at: indexPath) == self {
                      self?.productImageView.image = image
                  }
              }
          }
    }
}
