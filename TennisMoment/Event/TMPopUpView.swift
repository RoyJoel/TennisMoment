//
//  TMPopUpView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/15.
//

import Foundation
import UIKit

class TMPopUpView: TMTableView {
    lazy var menuList: TMTableView = {
        let view = TMTableView()
        return view
    }()

    func setup(config: TMPopUpViewConfig) {
        addSubview(menuList)
        menuList.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        menuList.setupUI()
        let config = TMTableViewConfig(cells: config.cells, rowHeight: config.rowHeight, rowNum: config.rowNum, rowNumWhenFold: 1, rowNumWhenUnfold: 4)
        menuList.setupEvent(config: config)
    }
}

class TMPopUpViewConfig {
    var cells: [TMPopUpViewCell]
    var rowHeight: CGFloat
    var rowNum: Int

    init(cells: [TMPopUpViewCell], rowHeight: CGFloat, rowNum: Int) {
        self.cells = cells
        self.rowHeight = rowHeight
        self.rowNum = rowNum
    }
}
