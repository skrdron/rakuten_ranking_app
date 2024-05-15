//
//  RankingAPI.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation

public class RankingAPI{
    private let apiClient: APIClient

    
    public init(apiClient: APIClient) {
      self.apiClient = apiClient
    }
    
    
    func requestRanking(sex: String, completion: @escaping (Result<Ranking, APIError>) -> Void){
        apiClient.request(RankingAPIRequest.getRanking(sex: sex)) { result in
            switch result {
            case .success(let data):
                if let result = try? JSONDecoder().decode(Ranking.self, from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

public protocol RankingRequest: Request {
}

public extension RankingRequest {
    var baseURL: URL {
        #if DEBUG
          // デバッグ（必要であればここでURLを開発用途化に変える）*別モジュールなのでDUMMYは使えない
          return URL(string: "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20220601?applicationId=1054850339030324271")!
        #else
          // 本番
          return URL(string: "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20220601?applicationId=1054850339030324271")!
        #endif
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return ""
    }
}

public enum RankingAPIRequest: RankingRequest {
    case getRanking(sex: String)
    public var parameter: [String: Any] {
        switch self {
        case .getRanking(let sex):
            if sex.isEmpty {
                return [:]
            } else {
                return ["sex": sex]
            }
        }
    }
}

                          

