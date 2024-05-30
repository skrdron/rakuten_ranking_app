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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        addEllipsisButton()
        hideKeyboardWhenTappedAround()
    }
    
    /// searchBarをNavigationBarに設置する関数
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
    
    /// SVGファイルを使用してNavigationBarにボタンを追加するための処理
    func addEllipsisButton() {
        guard let filePath = Bundle.main.path(forResource: "more_2_line", ofType: "svg") else {
            print("SVG画像が見つからない")
            return
        }
        // ライブラリのバグで、最初一回のSVG読み込みに失敗してしまうのを回避するためのコード
        _ = SVGKImage(contentsOfFile: filePath)?.uiImage
        let svgImage = SVGKImage(contentsOfFile: filePath)?.uiImage
        let ellipsisButton = UIBarButtonItem(image: svgImage, style: .plain, target: self, action: #selector(self.ellipsisButtonTapped))
        self.navigationItem.rightBarButtonItem = ellipsisButton
    }
    
    
    @objc func ellipsisButtonTapped() {
        print("elliipsがタップされました")
    }
    
    /// 画面上の任意の場所をタップしたときにキーボードを閉じるためのタップジェスチャーを設定
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// 検索ボタンが押されたときにキーボードを閉じる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
