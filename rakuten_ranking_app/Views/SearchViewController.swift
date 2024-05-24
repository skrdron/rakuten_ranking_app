//
//  SearchView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/08.
//

import UIKit
import SVGKit


class SearchViewController: UIViewController,UISearchBarDelegate  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ellipsis: UIImageView!
    
    //SearchModelのインスタンス
    var searchModel = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        addEllipsisButton()
    }

    ///searchBarをNavigationBarに設置する関数
    func setupSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "商品を検索"
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = .default
            navigationItem.titleView = searchBar
            self.searchBar = searchBar
        }
     }
    
    ///SVGファイルを使用してNavigationBarにボタンを追加するための処理
    func addEllipsisButton() {
        guard let filePath = Bundle.main.path(forResource: "more_2_line", ofType: "svg") else {
            print("SVG画像が見つからない")
            return
        }
        //ライブラリのバグで、最初一回のSVG読み込みに失敗してしまうのを回避するためのコード
        _ = SVGKImage(contentsOfFile: filePath)?.uiImage
        let svgImage = SVGKImage(contentsOfFile: filePath)?.uiImage
        let ellipsisButton = UIBarButtonItem(image: svgImage, style: .plain, target: self, action: #selector(self.ellipsisButtonTapped))
        self.navigationItem.rightBarButtonItem = ellipsisButton
    }


    @objc func ellipsisButtonTapped() {
        print("elliipsがタップされました")
    }
    
    
    ///SearchBarに入力された文字を取得する処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        print(searchText)
        
        //SearchModelに検索データをセット
        searchModel.setSearchData(searchText)
        
        // 子ViewControllerのインスタンスを作成し、検索文字列を渡す
        let searchedItemsVC = SearchedItemsViewController()
        searchedItemsVC.searchString = searchText
        navigationController?.pushViewController(searchedItemsVC, animated: true)
    }
}
