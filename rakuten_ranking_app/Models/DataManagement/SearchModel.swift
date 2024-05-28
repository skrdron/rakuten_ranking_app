//
//  SearchModel.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/24.
//

import Foundation

class SearchModel {
    let notificationCenter = NotificationCenter.default
    private let apiClient: APIClient
    
    //取得したSearchデータを保持
    private(set) var search: Search? {
        didSet {
            //通知に用いる追加情報を格納するための空のuserInfo辞書を初期化
            var userInfo: [String: Any] = [:]
            //searchプロパティがnilでないかをチェック
            if let validSearch = search {
                userInfo[NotificationConst.UserInfoKeysForSearch.search] = validSearch
                notificationCenter.post(
                    name: .init(rawValue: NotificationConst.searchNotificationName),
                    object: nil,
                    userInfo: userInfo.isEmpty ? nil : userInfo
                )
                       
                // 検索結果の最初の30件をコンソールに表示
                printSearchResults(validSearch)
            }
        }
    }
    
    init(apiClient: APIClient) {
       self.apiClient = apiClient
    }
    
    //検索バーで取得した文字をSearchedItemsViewControllerから受け取る
    func fetchSearchResults(with searchText: String) {
        print("次の検索文字列をモデルで受け取った: \(searchText)")
        // SearchAPIを使って検索を行う
        let searchAPI = SearchAPI(apiClient: apiClient)
        searchAPI.requestSearch(keyword: searchText) { [weak self] result in
            DispatchQueue.main.async {
                if case .success(let search) = result {
                   self?.search = search
                }
            }
        }
    }
    
    //検索結果をコンソールに表示するメソッド (30件)
    private func printSearchResults(_ search: Search) {
          let items = search.items.prefix(30)
          for item in items {
              let name = item.item.itemName
              let price = item.item.itemPrice
              print("商品名: \(name), 価格: \(price)")
          }
      }
}
