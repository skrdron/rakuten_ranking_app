//
//  constants.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/15.
//

import Foundation

//ここで固定値を定義し渡す
struct const {
    static let baseURL = "https://app.rakuten.co.jp/services/api/"
    static let applicationId = "1054850339030324271"
    //APIリクエストURLで?applicationId が2回出現している　↓修正
    static let urlPath = "IchibaItem/Ranking/20220601"
}


