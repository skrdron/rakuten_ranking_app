//
//  SearchedItemsViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/24.
//

import UIKit

class SearchedItemsViewController:UIViewController, UISearchBarDelegate, UITableViewDelegate  {
    
    // 検索文字列を保持するプロパティ
    var searchString: String?
    
    var model: SearchModel?{
      didSet {
        registerModel()
      }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var items: [SearchItemElement] = []
    
    deinit {
      model?.notificationCenter.removeObserver(self)
    }
    
    private func registerModel() {
        _ = model?.notificationCenter.addObserver(forName: .init(rawValue: NotificationConst.searchNotificationName),
                                              object: nil, queue: nil) { [weak self] notification in
            if let search = notification.userInfo?[NotificationConst.UserInfoKeysForSearch.search] as? Search {
                self?.items = search.items
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        model = SearchModel(apiClient: DefaultAPIClient.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBarDelegate()
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
        model?.fetchSearchResults(with: searchText)
    }
}

extension SearchedItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        let item = items[indexPath.row].item
        
        cell.configure(with: item, at: indexPath, in: tableView)
        
        return cell
    }
}


