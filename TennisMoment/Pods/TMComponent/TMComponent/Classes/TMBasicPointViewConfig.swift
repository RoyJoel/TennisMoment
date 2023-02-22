//
//  TMBasicPointConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

open class TMBasicPointViewConfig {
    public var isLeft: Bool
    public var num: Int
    public var font: UIFont

    public init(isLeft: Bool, font: UIFont, num: Int) {
        self.isLeft = isLeft
        self.font = font
        self.num = num
    }
}
