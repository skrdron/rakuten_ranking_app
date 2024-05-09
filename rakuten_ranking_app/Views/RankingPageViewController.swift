//
//  RankingPageViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingPageViewController: UIPageViewController {
    
    // ① PageView上で表示するViewControllerを管理する配列
    private var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // ②初期化
        self.initPageView()
    }
    
    // ②初期化（PageViewで表示するViewをセット）
    func initPageView(){
        // PageViewControllerで表示するViewControllerをインスタンス化（オプショナルバインディング）
        guard
            let rankingAllVC = storyboard?.instantiateViewController(withIdentifier: "rankingAll") as? RankingForAllViewController,
            let rankingMaleVC = storyboard?.instantiateViewController(withIdentifier: "rankingMale") as? RankingForMaleViewController,
            let rankingFemaleVC = storyboard?.instantiateViewController(withIdentifier: "rankingFemale") as? RankingForFemaleViewController 
        else {
            print("エラー:storyboardからViewControllerの取得に失敗")
            return
        }
        // インスタンス化したViewControllerを配列に追加
        self.controllers = [rankingAllVC, rankingMaleVC, rankingFemaleVC]
            
        if !controllers.isEmpty {
            // 最初に表示するViewControllerを指定する
            setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
            // PageViewControllerのDataSourceとの関連付け
            self.dataSource = self
        }
    }
}


extension RankingPageViewController: UIPageViewControllerDataSource {
    // スクロールするページ数
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }

    // 左にスワイプした時の処理
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }
    
    // 右にスワイプした時の処理
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
}
