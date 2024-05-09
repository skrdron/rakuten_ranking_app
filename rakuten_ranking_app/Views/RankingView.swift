//
//  RankingView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit

class RankingView: UIViewController {

    private var rankingPageViewController: RankingPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // RankingPageViewControllerの初期化
        rankingPageViewController = RankingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        // 子ビューコントローラとして追加
        addChild(rankingPageViewController)
        view.addSubview(rankingPageViewController.view)
        // 制約の設定（rankingPageViewControllerのビューがRankingViewのビューにフィットするように）
        rankingPageViewController.view.frame = view.bounds
        rankingPageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 子ビューコントローラとしての追加を完了
        rankingPageViewController.didMove(toParent: self)
    }
}
