//
//  TMButtonConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation

class TMButtonConfig {
    var title: String
    var action: Selector
    var actionTarget: Any
    var relatedView: TMPointRecordView

    init(title: String, action: Selector, actionTarget: Any, relatedView: TMPointRecordView) {
        self.title = title
        self.action = action
        self.actionTarget = actionTarget
        self.relatedView = relatedView
    }
//    static func defaultConfig() -> TMComponentConfig {
//        return TMButtonConfig(title: "", action: #selector(defaultMethod), actionTarget: self)
//    }
//    @objc func defaultMethod() {}
}
