//
//  RankingAllView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit


class RankingForAllViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRankingData()
    }
    
    func fetchRankingData() {
        let url: URL = URL(string: "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20220601?applicationId=1054850339030324271")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
          // コンソールに出力
          print("data: \(String(describing: data))")
          print("response: \(String(describing: response))")
          print("error: \(String(describing: error))")
          do{
            //JSONに変換&バースする
            let rankingData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
              print(rankingData) // Jsonの中身を表示
            }
            catch {
             print(error)
            }
          }
        )
        task.resume()
    }
}
