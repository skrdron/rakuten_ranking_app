//
//  RankingView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit


//選択されたタブに応じて表示するビューコントローラを変更するためのデリゲート
protocol RankingViewControllerDelegate: AnyObject {
    func changeViewControllerByTab(at index: Int)
}

class RankingViewController: UIViewController, UIPageViewControllerDelegate, RankingPageViewControllerDelegate {
    
    @IBOutlet weak var switchedView: UIView!
    //segmentedControlの紐付け
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var rankingPageViewController: RankingPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //わかりやすい様に切り分ける
        setupPageViewController()
        setupSegmentedControl()
    }
    
    private func setupPageViewController() {
        //ストーリーボードからRankingPageViewControllerをインスタンス化
        guard let rankingPageViewController = storyboard?.instantiateViewController(withIdentifier: "rankingPageViewController") as? RankingPageViewController else {
            print("StoryboardからRankingPageViewControllerのインスタンス化に失敗しました")
            return
        }
        
        addChild(rankingPageViewController)
        //switchedViewに追加
        if let switchedView = switchedView {
            switchedView.addSubview(rankingPageViewController.view)
            rankingPageViewController.view.frame = switchedView.bounds
            rankingPageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            rankingPageViewController.didMove(toParent: self)
            self.rankingPageViewController = rankingPageViewController
            //デリゲート
            rankingPageViewController.customDelegate = self
        } else {
            print("switchedViewがStoryboardで正しく接続されていません。")
        }
    }
    //セグメントコントロールを設定
    private func setupSegmentedControl() {
        if let segmentedControl = segmentedControl {
            segmentedControl.removeAllSegments()
            segmentedControl.insertSegment(withTitle: "総合", at: 0, animated: false)
            segmentedControl.insertSegment(withTitle: "男性", at: 1, animated: false)
            segmentedControl.insertSegment(withTitle: "女性", at: 2, animated: false)
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        } else {
            print("segmentedControlがStoryboardで正しく接続されていません。")
        }
    }
    
    //タップされたときに呼び出されるアクション
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        rankingPageViewController?.switchToViewController(at: sender.selectedSegmentIndex)
    }
    
    //ビューコントローラがスワイプで変更されたときにセグメントの選択を更新
    func changeTabByViewController(at index: Int) {
        segmentedControl?.selectedSegmentIndex = index
    }
}
