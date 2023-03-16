//
//  TMGameStatsView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/10.
//

import Foundation
import TMComponent

class TMGameStatsView: UIView {
    var statsView: TMmultiplyConfigurableView = {
        let view = TMmultiplyConfigurableView()
        return view
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        addSubview(statsView)
        statsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }

    func setupEvent(game: Game, stats1: Stats, stats2: Stats) {
        let result = TMDataConvert.read(from: game.result, setConfigNum: game.setNum, gameConfigNum: game.gameNum)

        let playerConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, iconName: "", isServingOnLeft: true, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 23), leftNum: game.player1LoginName, rightNum: game.player2LoginName)
        let resultConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "RESULT", iconName: "checkmark.circle", isServingOnLeft: result[0][0] > result[0][1] ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(result[0][0])", rightNum: "\(result[0][1])")
        let aceConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "ACE", iconName: "checkmark.circle", isServingOnLeft: stats1.aces > stats2.aces ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(stats1.aces)", rightNum: "\(stats2.aces)")
        let winnerConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "WINNER", iconName: "checkmark.circle", isServingOnLeft: stats1.forehandWinners + stats1.backhandWinners > stats2.forehandWinners + stats2.backhandWinners ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(stats1.forehandWinners + stats1.backhandWinners)", rightNum: "\(stats2.forehandWinners + stats2.backhandWinners)")
        let ueConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "UNFORVED ERROR", iconName: "checkmark.circle", isServingOnLeft: stats1.unforcedErrors > stats2.unforcedErrors ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(stats1.unforcedErrors)", rightNum: "\(stats2.unforcedErrors)")
        let netPointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: "NET POINT", iconName: "checkmark.circle", isServingOnLeft: stats1.netPoints > stats2.netPoints ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(stats1.netPoints)", rightNum: "\(stats2.netPoints)")

        let viewConfig = TMmultiplyConfigurableViewConfig(rowHeight: 48, rowSpacing: 0, numberOfRow: 6, configs: [playerConfig, resultConfig, aceConfig, winnerConfig, ueConfig, netPointConfig])

        statsView.setup(with: viewConfig)
    }
}
