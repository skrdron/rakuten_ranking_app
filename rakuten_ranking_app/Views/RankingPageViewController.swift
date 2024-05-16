//
//  RankingPageViewController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/09.
//

import UIKit

protocol RankingPageViewControllerDelegate: AnyObject {
    func changeTabByViewController(at index: Int)
}

class RankingPageViewController: UIPageViewController,UIPageViewControllerDelegate {
    weak var updateTabNotificationDelegate: RankingPageViewControllerDelegate?
            
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
        self.controllers = [rankingForAllVC, rankingForMaleVC, rankingForFemaleVC]
            
        if !controllers.isEmpty {
            setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
            self.dataSource = self
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let visibleViewController = viewControllers?.first, let index = controllers.firstIndex(of: visibleViewController) {
                updateTabNotificationDelegate?.changeTabByViewController(at: index)
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

    func switchToViewController(at index: Int) {
       if index >= 0 && index < controllers.count {
         setViewControllers([controllers[index]], direction: .forward, animated: false, completion: nil)
       }
    }
}
