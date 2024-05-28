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
    var searchModel = SearchModel(apiClient: DefaultAPIClient.shared)
    @IBOutlet weak var tableView: UITableView!
    
    private var items: [SearchItemElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    ///親VC(SearchViewController)の取得
    private func setupSearchBarDelegate() {
        // 親のViewControllerから検索バーを参照し、delegateとして自分を設定
        if let parentVC = self.parent as? SearchViewController {
            parentVC.searchBar.delegate = self
        }
    }
    
    ///SearchBarに入力された文字を取得しモデルに渡す処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        print("検索バーに入力された文字: \(searchText)")
        searchModel.fetchSearchResults(with: searchText)
    }
    
}
