//
//  SearchModel.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/24.
//

import Foundation

class SearchModel {
    let notificationCenter = NotificationCenter.default
    
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
}
