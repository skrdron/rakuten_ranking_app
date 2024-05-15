//
//  RankingAPI.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation


public class RankingAPI{
    private let apiClient: APIClient

    
    init(apiClient: APIClient) {
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

public protocol RankingRequest: Request {}

public extension RankingRequest {
    /*
      APIのURLを作成するときにbaseURLをAPICommonURLから引っ張ってくる
      それ以降のURLを let　xxx = "IchibaItem/Ranking/20220601?applicationId=1054850339030324271"として定義し、使う時に
      fetchUrl = baseURL + xxxの様にして作成したい
      URL()の括弧内に上記のurlを代入？
    */
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return const.urlPath
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

                          

