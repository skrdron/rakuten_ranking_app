//
//  RankingPageViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

class RankingPageViewController: UIPageViewController {
    
    private var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPageView()
    }
    
    func initPageView(){

        guard
            let rankingForAllVC = storyboard?.instantiateViewController(withIdentifier: "rankingAll") as? RankingForAllViewController,
            let rankingForMaleVC = storyboard?.instantiateViewController(withIdentifier: "rankingMale") as? RankingForMaleViewController,
            let rankingForFemaleVC = storyboard?.instantiateViewController(withIdentifier: "rankingFemale") as? RankingForFemaleViewController
        else {
            print("エラー:storyboardからViewControllerの取得に失敗")
            return
        }

        self.controllers = [rankingForAllVC, rankingForMaleVC, rankingForFemaleVC]
            
        if !controllers.isEmpty {
            setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
            self.dataSource = self
        }
    }
}


extension RankingPageViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
    
    //RankingViewControllerから呼び出される → 表示されているビューコントローラーを切り替える
    func switchToViewController(at index: Int) {
       //配列の範囲外へのアクセスを防ぐ
       if index >= 0 && index < controllers.count {
         //表示するビューコントローラーを設定:選択されたインデックスのVCを抽出し、そのVCを現在表示するように設定
         setViewControllers([controllers[index]], direction: .forward, animated: false, completion: nil)
       }
    }
}
