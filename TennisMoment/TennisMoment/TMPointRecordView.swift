//
//  TMPointRecordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import TMComponent

class TMPointRecordView: TMView {
    var config = TMPointRecordViewConfig(rowHeight: 0, rowSpacing: 0, font: UIFont(), isTitleHidden: true, isServingOnLeft: true, setLeftNum: "0", setRightNum: "0", gameLeftNum: "0", gameRightNum: "0", pointLeftNum: "0", pointRightNum: "0")

    lazy var pointRecordView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    func setup(with config: TMPointRecordViewConfig) {
        setupUI()
        let setConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "SET", iconName: "TennisBall", isServingOnLeft: config.isServingOnLeft, areBothServing: false, isComparing: false, font: config.font, leftNum: config.setLeftNum, rightNum: config.setRightNum)
        let gameConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "GAME", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: config.gameLeftNum, rightNum: config.gameRightNum)
        let pointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "POINT", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: true, font: config.font, leftNum: config.pointLeftNum, rightNum: config.pointRightNum)
        let pointRecordViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: config.rowHeight, rowSpacing: config.rowSpacing, numberOfRow: 3, configs: [setConfig, gameConfig, pointConfig])
        setupEvent(config: pointRecordViewConfig)
    }

    func updateLeftData(at index: Int, isServingOnLeft: Bool, newNum: String) {
        pointRecordView.updateLeftDate(at: index, isServingOnLeft: isServingOnLeft, newNum: newNum)
    }

    func updateRightData(at index: Int, isServingOnRight: Bool, newNum: String) {
        pointRecordView.updateRightDate(at: index, isServingOnRight: !isServingOnRight, newNum: newNum)
    }

    func reset(with config: TMPointRecordViewConfig) {
        let setConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "SET", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: config.setLeftNum, rightNum: config.setRightNum)
        let gameConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "GAME", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: config.gameLeftNum, rightNum: config.gameRightNum)
        let pointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "POINT", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: true, font: config.font, leftNum: config.pointLeftNum, rightNum: config.pointRightNum)
        let pointRecordViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: config.rowHeight, rowSpacing: config.rowSpacing, numberOfRow: 3, configs: [setConfig, gameConfig, pointConfig])
        pointRecordView.reset(with: pointRecordViewConfig)
    }

    func setupUI() {
        addSubview(pointRecordView)
        pointRecordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupEvent(config: TMmultiplyConfigurableViewConfig) {
        pointRecordView.setup(with: config)
    }
}
