//
//  APIClient.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/13.
//

import Foundation
import Alamofire


enum APIError: Error {
    case network
    case server
    case invalidJSON
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return "ネットワークの接続状態を確認してください。"
        case .server:
            return "サーバーと通信できません。"
        case .invalidJSON:
            return "JSONパース失敗。"
        }
    }
}

public enum HTTPMethod: String {
    case post
    case get
}

public protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var timeout: TimeInterval { get }
    var contentType: String { get }
    var accept: String { get }
    //parameters プロパティを Request プロトコルに戻す
    var parameters: [String: Any] { get }
    
    func makeRequest() -> URLRequest
}

public extension Request {
    var headerFields: [String: String] {
        return [:]
    }

    var timeout: TimeInterval {
        return 65
    }

    var contentType: String {
        return ""
    }

    var accept: String {
        return ""
    }

    func makeRequest() -> URLRequest {
        let baseURL = const.baseURL
        guard let baseURL = URL(string: baseURL) else {
            fatalError("無効なbaseURL")
        }
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url, timeoutInterval: timeout)
        urlRequest.httpMethod = method.rawValue
        
        //protocolのparameterを取得し、一旦ローカル変数に代入してあげる
        var parameters = self.parameters
        //parameterにupdateValueでapplicationIdの情報を追加する
        parameters.updateValue(const.applicationId, forKey: "applicationId")
        //URLパラメータを構築する
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems = [URLQueryItem]()
        //パラメータをURLクエリ項目に変換する
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
               
        urlComponents.queryItems = queryItems
        urlRequest.url = urlComponents.url

        
        headerFields.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if case .post = method {
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        urlRequest.setValue(accept, forHTTPHeaderField: "Accept")
        return urlRequest
    }
}

protocol APIClient {
    func request(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void)
}

final class DefaultAPIClient: APIClient {
    public static let shared = DefaultAPIClient()

    private init() {}

    public func request(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void) {
         AF.request(request.makeRequest()).responseData { response in
             switch response.result {
             case .success(let data):
                 completion(.success(data))
             case .failure:
                 completion(.failure(response.response?.statusCode == nil ? .network : .server))
             }
         }
     }
}
