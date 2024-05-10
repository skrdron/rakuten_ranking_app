//
//  RankingPageViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

//VCをスワイプするとTabを変えるdelegateの設定のためにprotocolを設定
protocol RankingPageViewControllerDelegate: AnyObject {
    //pageVCがスワイプによって切り替わった後、セグメントを更新する
    func changeTabByViewController(at index: Int)
}

class RankingPageViewController: UIPageViewController,UIPageViewControllerDelegate {
    weak var customDelegate: RankingPageViewControllerDelegate?
            
    private var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
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
        //controllers配列に追加
        self.controllers = [rankingForAllVC, rankingForMaleVC, rankingForFemaleVC]
            
        if !controllers.isEmpty {
            //最初のビューコントローラをセット
            setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
            self.dataSource = self
        }
    }
    
    //ページ遷移が完了したらデリゲートメソッド
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let visibleViewController = viewControllers?.first, let index = controllers.firstIndex(of: visibleViewController) {
                customDelegate?.changeTabByViewController(at: index)
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
    
    //指定されたインデックスに基づいて特定のビューコントローラを表示
    func switchToViewController(at index: Int) {
       //配列の範囲外へのアクセスを防ぐ
       if index >= 0 && index < controllers.count {
         //表示するビューコントローラーを設定:選択されたインデックスのVCを抽出し、そのVCを現在表示するように設定
         setViewControllers([controllers[index]], direction: .forward, animated: false, completion: nil)
       }
    }
}
