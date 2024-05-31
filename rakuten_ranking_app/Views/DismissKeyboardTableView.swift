//
//  CustomTableView.swift
//  rakuten_ranking_app
//
//  Created by 櫻田龍之助 on 2024/05/31.
//

import UIKit

class DismissKeyboardTableView: UITableView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}
