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
    private(set) var search: Search! {
        didSet {
            //searchプロパティが新しいデータで更新されると、通知を送信
            notificationCenter.post(
                name: .init(rawValue: NotificationConst.searchNotificationName),
                object: nil,
                userInfo: [
                    NotificationConst.UserInfoKeysForSearch.search: search!,
                ]
            )
        }
    }
    
    // 検索データをセットする
    func setSearchData(_ data: Search) {
        self.search = data
    }
}
