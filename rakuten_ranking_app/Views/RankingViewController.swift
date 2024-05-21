///Users/ryunosukesakurada/Desktop/dev/swift_tutorial/rakuten_ranking_app/rakuten_ranking_app/Base.lproj/Main.storyboard
//  RankingView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit


protocol RankingViewControllerDelegate: AnyObject {
    func changeViewControllerByTab(at index: Int)
}

class RankingViewController: UIViewController, UIPageViewControllerDelegate, RankingPageViewControllerDelegate {
    
    @IBOutlet weak var switchedView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var rankingPageViewController: RankingPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupSegmentedControl()
    }
    
    private func setupPageViewController() {
        guard let rankingPageViewController = storyboard?.instantiateViewController(withIdentifier: "rankingPageViewController") as? RankingPageViewController else {
            print("StoryboardからRankingPageViewControllerのインスタンス化に失敗しました")
            return
        }
        
        addChild(rankingPageViewController)
        guard let switchedView = switchedView else {
            print("switchedViewがStoryboardで正しく接続されていません。")
            return
        }
                
        switchedView.addSubview(rankingPageViewController.view)
        rankingPageViewController.view.frame = switchedView.bounds
        rankingPageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rankingPageViewController.didMove(toParent: self)
        self.rankingPageViewController = rankingPageViewController
        rankingPageViewController.updateTabNotificationDelegate = self
    }

    private func setupSegmentedControl() {
         guard let segmentedControl = segmentedControl else {
             print("segmentedControlがStoryboardで正しく接続されていません。")
             return
         }
         segmentedControl.removeAllSegments()
         segmentedControl.insertSegment(withTitle: "総合", at: 0, animated: false)
         segmentedControl.insertSegment(withTitle: "男性", at: 1, animated: false)
         segmentedControl.insertSegment(withTitle: "女性", at: 2, animated: false)
         segmentedControl.selectedSegmentIndex = 0
         segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
     }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        rankingPageViewController?.switchToViewController(at: sender.selectedSegmentIndex)
    }
    
    func changeTabByViewController(at index: Int) {
        segmentedControl?.selectedSegmentIndex = index
    }
}
