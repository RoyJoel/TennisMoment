//
//  TMScoreCtrollerButton.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation
import TMComponent

class TMScoreCtrollerButton: TMButton {
    var relatedPointRecordView = TMPointRecordView()
    var relatedInfoView = TMInfoView()
    var controllerConfig = TMScoreCtrollerButtonConfig(title: "", action: #selector(method), actionTarget: TMScoreCtrollerButton.self, relatedPointRecordView: TMPointRecordView(), relatedInfoView: TMInfoView())
    func setUp(with config: TMScoreCtrollerButtonConfig) {
        controllerConfig = config
        setupUI()
        setupEvent(config: TMButtonConfig(title: config.title, action: config.action, actionTarget: config.actionTarget))
    }
}

class TMScoreCtrollerButtonConfig: TMButtonConfig {
    var relatedPointRecordView: TMPointRecordView
    var relatedInfoView: TMInfoView

    init(title: String, action: Selector, actionTarget: Any, relatedPointRecordView: TMPointRecordView, relatedInfoView: TMInfoView) {
        self.relatedPointRecordView = relatedPointRecordView
        self.relatedInfoView = relatedInfoView
        super.init(title: title, action: action, actionTarget: actionTarget)
    }
}
