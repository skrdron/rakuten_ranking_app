//
//  RankingView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit

//delegateの設定のためにprotocolを設定
protocol RankingViewControllerDelegate: AnyObject {
    func switchToViewController(at index: Int)
}

class RankingViewController: UIViewController, UIPageViewControllerDelegate {

    @IBOutlet weak var switchedView: UIView!
    //segmentedControlの紐付け
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var rankingPageViewController: RankingPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard let rankingPageViewController = storyboard?.instantiateViewController(withIdentifier: "rankingPageViewController") as? RankingPageViewController else {
               print("StoryboardからRankingPageViewControllerのインスタンス化に失敗しました")
               return
           }
  
        addChild(rankingPageViewController)
        if let switchedView = switchedView {
            switchedView.addSubview(rankingPageViewController.view)
            rankingPageViewController.view.frame = switchedView.bounds
            rankingPageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        rankingPageViewController.didMove(toParent: self)
        self.rankingPageViewController = rankingPageViewController
        
        //delegateの設定
        rankingPageViewController.delegate = self
        
        // segmentedControlの設定
        if let segmentedControl = segmentedControl {
            segmentedControl.removeAllSegments()
            segmentedControl.insertSegment(withTitle: "総合", at: 0, animated: false)
            segmentedControl.insertSegment(withTitle: "男性", at: 1, animated: false)
            segmentedControl.insertSegment(withTitle: "女性", at: 2, animated: false)
            segmentedControl.selectedSegmentIndex = 0
            //アクションを割り当てる　セグメントの選択が変更された時 → segmentChanged(_:)メソッドを呼び出す
            segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        } else {
            print("segmentedControlがStoryboardで正しく接続されていません。")
        }
    }
    
    
    //segmentChanged(_:)メソッド
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        //現在選択されているセグメントのインデックスを取得
        rankingPageViewController.switchToViewController(at: sender.selectedSegmentIndex)
    }
}


