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
    var relatedPointRecordView: TMPointRecordView
    var relatedInfoView: TMInfoView

    init(title: String, action: Selector, actionTarget: Any, relatedPointRecordView: TMPointRecordView, relatedInfoView: TMInfoView) {
        self.title = title
        self.action = action
        self.actionTarget = actionTarget
        self.relatedPointRecordView = relatedPointRecordView
        self.relatedInfoView = relatedInfoView
    }
}
