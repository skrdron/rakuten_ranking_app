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
            }
            notificationCenter.post(
                name: .init(rawValue: NotificationConst.searchNotificationName),
                object: nil,
                userInfo: userInfo.isEmpty ? nil : userInfo
            )
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
                switch result {
                case .success(let searchResults):
                    self?.search = searchResults
                    print("検索結果を取得しました。")
                case .failure(let error):
                    print("検索に失敗しました: \(error)")
                    self?.search = nil
                }
            }
        }
    }
}
