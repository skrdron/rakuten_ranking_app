//
//  TabBarController.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
        view.backgroundColor = .systemBackground
    }
    
    private func configureTabs(){
        let vc1 = RankingView()
        let vc2 = SearchView()
        let vc3 = BookmarkView()
        
        //タブイメージの設定
        vc1.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "bookmark")
        
        //タブタイトルの設定
        vc1.title = "ランキング"
        vc2.tabBarItem.title = "検索"
        vc3.title = "ブックマーク"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([nav1,nav2,nav3], animated: true)
    }
    
}
