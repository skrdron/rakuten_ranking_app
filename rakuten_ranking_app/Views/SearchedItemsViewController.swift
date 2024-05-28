//
//  SearchedItemsViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/24.
//

import UIKit

class SearchedItemsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // 検索文字列を保持するプロパティ
    var searchString: String?
    var searchModel = SearchModel()
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        print("検索バーに入力された文字: \(searchText)")
        searchModel.fetchSearchResults(with: searchText)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel.search?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchTableViewCell,
              let item = searchModel.search?.items[indexPath.row].item else {
            return UITableViewCell()
        }
        cell.configure(with: item, at: indexPath, in: tableView)
        return cell
    }
}
