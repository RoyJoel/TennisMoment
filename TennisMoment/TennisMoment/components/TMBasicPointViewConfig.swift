//
//  TMBasicPointConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

class TMBasicPointViewConfig: TMComponentConfig {
    var isLeft: Bool
    var num: Int
    var font: UIFont
    
    init(isLeft: Bool, font: UIFont, num: Int) {
        self.isLeft = isLeft
        self.font = font
        self.num = num
    }
    
    static func defaultConfig() -> TMComponentConfig {
        return TMBasicPointViewConfig(isLeft: true, font: UIFont(), num: 0)
    }
    
    
}
