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
            //search プロパティが nil でないかをチェック
            if let validSearch = search {
                let userInfo = [NotificationConst.UserInfoKeysForSearch.search: validSearch]
                         
                // 通知を送信
                notificationCenter.post(
                    name: .init(rawValue: NotificationConst.searchNotificationName),
                    object: nil,
                    userInfo: userInfo
                )
            }
        }
    }
}
