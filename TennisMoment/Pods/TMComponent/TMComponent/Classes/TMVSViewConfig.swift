//
//  TMVSViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

open class TMVSViewConfig {
    public var isTitleViewAbovePointView: Bool
    public var title: String?
    public var leftConfig: TMBasicPointViewConfig
    public var rightConfig: TMBasicPointViewConfig

    public init(isTitleViewAbovePointView: Bool, title: String?, leftConfig: TMBasicPointViewConfig, rightConfig: TMBasicPointViewConfig) {
        self.isTitleViewAbovePointView = isTitleViewAbovePointView
        self.title = title
        self.leftConfig = leftConfig
        self.rightConfig = rightConfig
    }
}
