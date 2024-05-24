//
//  constants.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/15.
//

import Foundation

struct NetworkConst {
    static let baseURL = "https://app.rakuten.co.jp/services/api/"
    static let applicationId = "1054850339030324271"
}

struct APIPathConst {
    static let rankingAPIUrlPath = "IchibaItem/Ranking/20220601"
    static let searchAPIUrlPath = "IchibaItem/Search/20220601"
}

struct NotificationConst {
    static let rankingNotificationName = "ranking"
    static let searchNotificationName = "search"
    struct UserInfoKeysForRanking {
        static let ranking = "ranking"
        static let sexType = "sexType"
    }
    struct UserInfoKeysForSearch {
        static let search = "search"
    }
}


