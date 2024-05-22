//
//  ImageFetcher.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/21.
//

import Foundation
import UIKit

class ImageFetcher {
    static func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }

        task.resume()
    }
}
