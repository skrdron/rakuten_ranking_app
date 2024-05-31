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
    
    // 親の検索バーを取得
    var parentSearchBar: UISearchBar?
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        model?.notificationCenter.removeObserver(self)
    }
    
    private func registerModel() {
        model?.notificationCenter.addObserver(forName: .init(rawValue: NotificationConst.searchNotificationName),
                                              object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
            self?.updateEmptyLabelVisibility()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        model = SearchModel(apiClient: DefaultAPIClient.shared)
        
        emptyLabel.text = "商品がありません"
        emptyLabel.tintColor = UIColor.gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchBarDelegate()
    }
    
    /// 親VC(SearchViewController)の取得
    private func setupSearchBarDelegate() {
        // 親のViewControllerから検索バーを参照し、delegateとして自分を設定
        if let parentVC = self.parent as? SearchViewController {
            parentVC.searchBar.delegate = self
            parentSearchBar = parentVC.searchBar
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// SearchBarに入力された文字を取得しモデルに渡す処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        model?.fetchSearchResults(with: searchText)
        searchBar.resignFirstResponder()
    }
    
    private func updateEmptyLabelVisibility() {
        let itemCount = model?.search?.items.count ?? 0
        emptyLabel.isHidden = itemCount > 0
    }
}

extension SearchedItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = model?.search?.items.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        guard let item = model?.search?.items[indexPath.row] else {
            fatalError("データを取得できませんでした。")
        }
        
        cell.configure(with: item.item, at: indexPath, in: tableView)
        
        return cell
    }
}
