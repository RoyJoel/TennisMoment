//
//  TMPointRecordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import TMComponent

class TMPointRecordView: TMView {
    var config = TMPointRecordViewConfig(rowHeight: 0, rowSpacing: 0, font: UIFont(), isTitleHidden: true, isPlayer1Serving: true, player1SetNum: 0, player2SetNum: 0, player1GameNum: 0, player2GameNum: 0, player1PointNum: "0", player2PointNum: "0")

    var pointRecordView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    func setup(with config: TMPointRecordViewConfig) {
        setupUI()

        self.config = config

        let setConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "SET", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: "\(config.player1SetNum)", rightNum: "\(config.player2SetNum)")
        let gameConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "GAME", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: config.font, leftNum: "\(config.player1GameNum)", rightNum: "\(config.player2GameNum)")
        let pointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: config.isTitleHidden, title: "POINT", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: true, font: config.font, leftNum: "\(config.player1PointNum)", rightNum: "\(config.player2PointNum)")
        let pointRecordViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: config.rowHeight, rowSpacing: config.rowSpacing, numberOfRow: 3, configs: [setConfig, gameConfig, pointConfig])

        setupEvent(config: pointRecordViewConfig)
    }

    func updateData(liveScore: [[[Int]]], isPlayer1Serving: Bool, isPlayer1Left _: Bool, setConfigNum: Int, gameConfigNum: Int) {
        let result = TMDataConvert.read(from: liveScore, setConfigNum: setConfigNum, gameConfigNum: gameConfigNum)

        config = TMPointRecordViewConfig(rowHeight: 0, rowSpacing: 0, font: UIFont(), isTitleHidden: true, isPlayer1Serving: isPlayer1Serving, player1SetNum: result[0][0], player2SetNum: result[0][1], player1GameNum: result[1][0], player2GameNum: result[1][1], player1PointNum: result[2][0].convertToPoint(), player2PointNum: result[2][1].convertToPoint())

        if !isPlayer1Serving {
            TMDataConvert.changePosition(with: &config.player1SetNum, and: &config.player2SetNum)
            TMDataConvert.changePosition(with: &config.player1GameNum, and: &config.player2GameNum)
            var t = config.player1PointNum
            config.player1PointNum = config.player2PointNum
            config.player2PointNum = t
            config.isPlayer1Serving.toggle()
        }
        pointRecordView.updateLeftDate(at: 0, isServingOnLeft: false, newNum: "\(config.player1SetNum)")
        pointRecordView.updateRightDate(at: 0, isServingOnRight: false, newNum: "\(config.player2SetNum)")
        pointRecordView.updateLeftDate(at: 1, isServingOnLeft: false, newNum: "\(config.player1GameNum)")
        pointRecordView.updateRightDate(at: 1, isServingOnRight: false, newNum: "\(config.player2GameNum)")
        pointRecordView.updateLeftDate(at: 2, isServingOnLeft: config.isPlayer1Serving, newNum: config.player1PointNum)
        pointRecordView.updateRightDate(at: 2, isServingOnRight: !config.isPlayer1Serving, newNum: config.player2PointNum)
    }

    func updateLeftData(at index: Int, isServingOnLeft: Bool, newNum: String) {
        pointRecordView.updateLeftDate(at: index, isServingOnLeft: isServingOnLeft, newNum: newNum)
    }

    func updateRightData(at index: Int, isServingOnRight: Bool, newNum: String) {
        pointRecordView.updateRightDate(at: index, isServingOnRight: isServingOnRight, newNum: newNum)
    }

    func scaleTo(newRowHeight: CGFloat, newRowSpacing: CGFloat, newFont: UIFont, isTitleHidden: Bool) {
        let setConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: isTitleHidden, title: "SET", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: newFont, leftNum: "\(config.player1SetNum)", rightNum: "\(config.player2SetNum)")
        let gameConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: isTitleHidden, title: "GAME", iconName: "TennisBall", isServingOnLeft: true, areBothServing: false, isComparing: false, font: newFont, leftNum: "\(config.player1GameNum)", rightNum: "\(config.player2GameNum)")
        let pointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: true, isTitleHidden: isTitleHidden, title: "POINT", iconName: "TennisBall", isServingOnLeft: config.isPlayer1Serving, areBothServing: false, isComparing: true, font: newFont, leftNum: config.player1PointNum, rightNum: config.player2PointNum)
        let pointRecordViewConfig = TMmultiplyConfigurableViewConfig(rowHeight: newRowHeight, rowSpacing: newRowSpacing, numberOfRow: 3, configs: [setConfig, gameConfig, pointConfig])
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
