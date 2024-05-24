//
//  SearchedItemsViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/24.
//

import UIKit

class SearchedItemsViewController: UIViewController, UISearchBarDelegate {
    
    // 検索文字列を保持するプロパティ
    var searchString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarDelegate()
    }
    
    ///親VC(SearchViewController)の取得
    private func setupSearchBarDelegate() {
          // 親のViewControllerから検索バーを参照し、delegateとして自分を設定
          if let parentVC = self.parent as? SearchViewController {
              parentVC.searchBar.delegate = self
          }
    }

    ///検索バーに入力されたテキストを受け取り、コンソールに出力
    @objc func searchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            print("子ViewControllerが受け取った検索文字列: \(searchText)")
            self.searchString = searchText
        }
    }
}
