//
//  RankingAPI.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation


class RankingAPI{
    private let apiClient: APIClient

    init(apiClient: APIClient) {
      self.apiClient = apiClient
    }
   
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
    case getRanking(sex: String)

    public var parameters: [String: Any] {
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

                          

