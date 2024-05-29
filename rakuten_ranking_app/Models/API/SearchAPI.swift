//
//  SearchAPI.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/29.
//

import Foundation

// APIクライアントを通じて検索データを取得す
class SearchAPI{
    private let apiClient: APIClient
    
    // apiClientを初期化
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func requestSearch(keyword: String, completion: @escaping (Result<Search, APIError>) -> Void) {
        apiClient.request(SearchAPIRequest.getSearch(keyword: keyword)) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(Search.self, from: data)
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

protocol SearchRequest: Request {}

extension SearchRequest {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return APIPathConst.searchAPIUrlPath
    }
}

enum SearchAPIRequest: SearchRequest {
    // キーワードを受け取り、それに応じたリクエストを作成
    case getSearch(keyword: String)
    
    public var parameters: [String: Any] {
        switch self {
        case .getSearch(let keyword):
            return [
                "keyword": keyword
            ]
        }
    }
}
