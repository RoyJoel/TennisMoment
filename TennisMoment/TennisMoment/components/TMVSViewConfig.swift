//
//  TMVSViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

class TMVSViewConfig: TMComponentConfig {
    var isTitleViewAbovePointView: Bool
    var title: String?
    var leftConfig: TMBasicPointViewConfig
    var rightConfig: TMBasicPointViewConfig
    
    init(isTitleViewAbovePointView: Bool, title: String?, leftConfig: TMBasicPointViewConfig, rightConfig: TMBasicPointViewConfig) {
        self.isTitleViewAbovePointView = isTitleViewAbovePointView
        self.title = title
        self.leftConfig = leftConfig
        self.rightConfig = rightConfig
    }
    
    static func defaultConfig() -> TMComponentConfig {
        return TMVSViewConfig(isTitleViewAbovePointView: true, title: nil, leftConfig: TMBasicPointViewConfig(isLeft: true, font: UIFont(), num: 0), rightConfig: TMBasicPointViewConfig(isLeft: false, font: UIFont(), num: 0))
    }
    
    
}
