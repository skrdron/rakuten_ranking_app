//
//  RankingView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet weak var switchedView: UIView!
    private var rankingPageViewController: RankingPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // RankingPageViewControllerの初期化（Storyboardからインスタンス化）
        guard let rankingPageViewController = storyboard?.instantiateViewController(withIdentifier: "rankingPageViewController") as? RankingPageViewController else {
               print("Failed to instantiate RankingPageViewController from storyboard.")
               return
           }

           // 子ビューコントローラとして追加
           addChild(rankingPageViewController)
           if let switchedView = switchedView {
               switchedView.addSubview(rankingPageViewController.view)
               // 制約の設定
               rankingPageViewController.view.frame = switchedView.bounds
               rankingPageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           }
           rankingPageViewController.didMove(toParent: self)
           // インスタンスを保持
           self.rankingPageViewController = rankingPageViewController
    }
}
