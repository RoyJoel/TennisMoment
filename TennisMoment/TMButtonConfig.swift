//
//  TMButtonConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import TMComponent

class TMButtonConfig {
    var title: String
    var action: Selector
    var actionTarget: Any

    init(title: String, action: Selector, actionTarget: Any) {
        self.title = title
        self.action = action
        self.actionTarget = actionTarget
    }
}
