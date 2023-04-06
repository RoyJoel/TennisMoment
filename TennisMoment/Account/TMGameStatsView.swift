//
//  TMGamegame.statsView.swift
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

    var game: Game?

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

    func setupEvent(game: Game) {
        self.game = game
        let result = TMDataConvert.setResult(from: game.result)

        let playerConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, iconName: "", isServingOnLeft: true, areBothServing: false, isComparing: false, font: UIFont.systemFont(ofSize: 23), leftNum: game.player1.name, rightNum: game.player2.name)
        let resultConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("RESULT", comment: ""), iconName: "checkmark.circle", isServingOnLeft: result[0] > result[1] ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(result[0])", rightNum: "\(result[1])")
        let aceConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("ACES", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.aces > game.player2Stats.aces ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.aces)", rightNum: "\(game.player2Stats.aces)")
        let winnerConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("WINNERS", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.forehandWinners + game.player1Stats.backhandWinners > game.player2Stats.forehandWinners + game.player2Stats.backhandWinners ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.forehandWinners + game.player1Stats.backhandWinners)", rightNum: "\(game.player2Stats.forehandWinners + game.player2Stats.backhandWinners)")
        let ueConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("UNFORCED ERRORS", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.unforcedErrors > game.player2Stats.unforcedErrors ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.unforcedErrors)", rightNum: "\(game.player2Stats.unforcedErrors)")
        let netPointConfig = TMPointComparingViewConfig(isTitleViewAbovePointView: false, isTitleHidden: false, title: NSLocalizedString("NET POINT", comment: ""), iconName: "checkmark.circle", isServingOnLeft: game.player1Stats.netPoints > game.player2Stats.netPoints ? true : false, areBothServing: false, isComparing: true, font: UIFont.systemFont(ofSize: 17), leftNum: "\(game.player1Stats.netPoints)", rightNum: "\(game.player2Stats.netPoints)")

        let viewConfig = TMmultiplyConfigurableViewConfig(rowHeight: 48, rowSpacing: 0, numberOfRow: 6, configs: [playerConfig, resultConfig, aceConfig, winnerConfig, ueConfig, netPointConfig])

        statsView.setup(with: viewConfig)
    }
}
