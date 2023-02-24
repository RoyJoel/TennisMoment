//
//  TMPointRecordViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import UIKit

class TMPointRecordViewConfig {
    var rowHeight: CGFloat
    var rowSpacing: CGFloat
    var font: UIFont
    var isTitleHidden: Bool
    var isServingOnLeft: Bool
    var setLeftNum: String
    var setRightNum: String
    var gameLeftNum: String
    var gameRightNum: String
    var pointLeftNum: String
    var pointRightNum: String

    init(rowHeight: CGFloat, rowSpacing: CGFloat, font: UIFont, isTitleHidden: Bool, isServingOnLeft: Bool, setLeftNum: String, setRightNum: String, gameLeftNum: String, gameRightNum: String, pointLeftNum: String, pointRightNum: String) {
        self.rowHeight = rowHeight
        self.rowSpacing = rowSpacing
        self.font = font
        self.isTitleHidden = isTitleHidden
        self.isServingOnLeft = isServingOnLeft
        self.setLeftNum = setLeftNum
        self.setRightNum = setRightNum
        self.gameLeftNum = gameLeftNum
        self.gameRightNum = gameRightNum
        self.pointLeftNum = pointLeftNum
        self.pointRightNum = pointRightNum
    }
}
