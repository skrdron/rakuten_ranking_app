//
//  RankingAPI.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation

//APIクライアントを通じてランキングデータを取得す
class RankingAPI{
    private let apiClient: APIClient

    //apiClientを初期化
    init(apiClient: APIClient) {
      self.apiClient = apiClient
    }
   
    //性別フィルター（sex）を使用してランキングデータを取得
    func requestRanking(sex: String, completion: @escaping (Result<Ranking, APIError>) -> Void) {
        apiClient.request(RankingAPIRequest.getRanking(sex: sex)) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Ranking.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.invalidJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

protocol RankingRequest: Request {}

extension RankingRequest {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return APIPathConst.rankingAPIUrlPath
    }
}

enum RankingAPIRequest: RankingRequest {
    //性別フィルターを受け取り、それに応じたリクエストを作成
    case getRanking(sex: String)
    //性別フィルターに基づいてリクエストのパラメータを設定
    public var parameters: [String: Any] {
        switch self {
        case .getRanking(let sex):
          switch sex {
              case "all":
               return [:]
              case "male":
                return ["sex": 1]
              case "female":
                return ["sex": 2]
              default:
                return [:]
          }
        }
    }
}

                          

