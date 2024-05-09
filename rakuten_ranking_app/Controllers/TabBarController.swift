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
        //Storyboard IDでインスタンス化
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rankingView = storyboard.instantiateViewController(withIdentifier: "rankingView") as! RankingView
        let searchView = storyboard.instantiateViewController(withIdentifier: "searchView") as! SearchView
        let bookmarkView = storyboard.instantiateViewController(withIdentifier: "bookmarkView") as! BookmarkView
            
        //タブイメージの設定
        rankingView.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        searchView.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        bookmarkView.tabBarItem.image = UIImage(systemName: "bookmark")
        
        //タブタイトルの設定
        rankingView.title = "ランキング"
        searchView.tabBarItem.title = "検索"
        bookmarkView.title = "ブックマーク"
        
        let navToRanking = UINavigationController(rootViewController: rankingView)
        let navToSearch = UINavigationController(rootViewController: searchView)
        let navToBookmark = UINavigationController(rootViewController: bookmarkView)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([navToRanking,navToSearch,navToBookmark], animated: true)
    }
    
}
