//
//  GameConfigToast.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import TMComponent
import UIKit

class TMGameConfigView: TMUserInteractionUnabledView {
    var isPlayer1Serving: Bool = true

    lazy var player1TextField: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var player2TextField: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var leftServerView: TMServerView = {
        let serveView = TMServerView()
        return serveView
    }()

    lazy var rightServerView: TMServerView = {
        let serveView = TMServerView()
        return serveView
    }()

    lazy var isGoldenGoalLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var isGoldenGoalConfigView: UISwitch = {
        let textField = UISwitch()
        return textField
    }()

    lazy var setConfigView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var gameConfigView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var surfaceConfigView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "TennisBlur")
        setCorner(radii: 15)
        clipsToBounds = false

        addSubview(player1TextField)
        addSubview(player2TextField)
        addSubview(leftServerView)
        addSubview(rightServerView)
        addSubview(isGoldenGoalLabel)
        addSubview(isGoldenGoalConfigView)
        addSubview(setConfigView)
        addSubview(gameConfigView)
        addSubview(surfaceConfigView)

        player1TextField.frame = CGRect(x: 220, y: 112, width: UIStandard.shared.screenWidth * 0.15, height: UIStandard.shared.screenHeight * 0.08)
        player2TextField.frame = CGRect(x: 480, y: 112, width: UIStandard.shared.screenWidth * 0.15, height: UIStandard.shared.screenHeight * 0.08)

        leftServerView.frame = CGRect(x: 170 + UIStandard.shared.screenWidth * 0.075, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)
        rightServerView.frame = CGRect(x: 430 + UIStandard.shared.screenWidth * 0.075, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)

        isGoldenGoalLabel.frame = CGRect(x: 214 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 30)

        isGoldenGoalConfigView.frame = CGRect(x: 234 + UIStandard.shared.screenWidth * 0.15, y: 154 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)

        setConfigView.frame = CGRect(x: 116, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: UIStandard.shared.screenHeight * 0.08)

        gameConfigView.frame = CGRect(x: 128 + UIStandard.shared.screenWidth * 0.15, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: UIStandard.shared.screenHeight * 0.08)

        surfaceConfigView.frame = CGRect(x: 140 + UIStandard.shared.screenWidth * 0.3, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: UIStandard.shared.screenHeight * 0.08)

        player1TextField.addTapGesture(player1TextField, #selector(tapToUnfold(_:)))
        player2TextField.addTapGesture(player2TextField, #selector(tapToUnfold(_:)))
        setConfigView.addTapGesture(setConfigView, #selector(tapToUnfold(_:)))
        gameConfigView.addTapGesture(gameConfigView, #selector(tapToUnfold(_:)))
        surfaceConfigView.addTapGesture(surfaceConfigView, #selector(tapToUnfold(_:)))

        player1TextField.isHidden = true
        player2TextField.isHidden = true
        leftServerView.isHidden = true
        rightServerView.isHidden = true
        isGoldenGoalLabel.isHidden = true
        isGoldenGoalConfigView.isHidden = true
        setConfigView.isHidden = true
        gameConfigView.isHidden = true
        surfaceConfigView.isHidden = true

        leftServerView.setup(isServing: isPlayer1Serving)
        rightServerView.setup(isServing: !isPlayer1Serving)

        isGoldenGoalLabel.text = "GoldenGoal"
        isGoldenGoalLabel.textAlignment = .center

        leftServerView.addTapGesture(self, #selector(changeServe))
        rightServerView.addTapGesture(self, #selector(changeServe))
        
        player1TextField.setup(player1TextField.bounds, player1TextField.layer.position, CGRect(x: 0, y: 0, width: player1TextField.bounds.width, height: player1TextField.bounds.height * 4), CGPoint(x: player1TextField.layer.position.x, y: player1TextField.layer.position.y * 2.5), 0.3)
        player2TextField.setup(player2TextField.bounds, player2TextField.layer.position, CGRect(x: 0, y: 0, width: player2TextField.bounds.width, height: player2TextField.bounds.height * 4), CGPoint(x: player2TextField.layer.position.x, y: player2TextField.layer.position.y * 2.5), 0.3)
        setConfigView.setup(setConfigView.bounds, setConfigView.layer.position, CGRect(x: 0, y: 0, width: setConfigView.bounds.width, height: setConfigView.bounds.height * 4), CGPoint(x: setConfigView.layer.position.x, y: setConfigView.layer.position.y * 2.5), 0.3)
        gameConfigView.setup(gameConfigView.bounds, gameConfigView.layer.position, CGRect(x: 0, y: 0, width: gameConfigView.bounds.width, height: gameConfigView.bounds.height * 4), CGPoint(x: gameConfigView.layer.position.x, y: gameConfigView.layer.position.y * 2.5), 0.3)
        surfaceConfigView.setup(surfaceConfigView.bounds, surfaceConfigView.layer.position, CGRect(x: 0, y: 0, width: surfaceConfigView.bounds.width, height: surfaceConfigView.bounds.height * 4), CGPoint(x: surfaceConfigView.layer.position.x, y: surfaceConfigView.layer.position.y * 2.5), 0.3)
    }

    func setupEvent(friends: [Player]) {
        var playerCells: [TMplayerSelectionCell] = []
        for friend in friends {
            let cell = TMplayerSelectionCell()
            cell.setup()
            cell.setupEvent(imageName: friend.icon, playerName: friend.name)
            playerCells.append(cell)
        }
        let player1TextFieldconfig = TMPopUpViewConfig(cells: playerCells, rowHeight: 40, rowNum: friends.count)
        let player2TextFieldconfig = TMPopUpViewConfig(cells: playerCells, rowHeight: 40, rowNum: friends.count)
        player1TextField.setup(config: player1TextFieldconfig)
        player2TextField.setup(config: player2TextFieldconfig)

        var setConfigCells: [TMPopUpViewCell] = []
        for i in 1 ... 6 {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: "\(i)")
            setConfigCells.append(cell)
        }
        let setConfig = TMPopUpViewConfig(cells: setConfigCells, rowHeight: 40, rowNum: 6)
        setConfigView.setup(config: setConfig)

        var gameConfigCells: [TMPopUpViewCell] = []
        for i in 1 ... 6 {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: "\(i)")
            gameConfigCells.append(cell)
        }
        let gameConfig = TMPopUpViewConfig(cells: gameConfigCells, rowHeight: 40, rowNum: 6)
        gameConfigView.setup(config: gameConfig)

        var surfaceConfigCells: [TMPopUpViewCell] = []
        for surface in SurfaceType.allCases {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: surface.rawValue)
            surfaceConfigCells.append(cell)
        }
        let surfaceConfig = TMPopUpViewConfig(cells: surfaceConfigCells, rowHeight: 40, rowNum: 6)
        surfaceConfigView.setup(config: surfaceConfig)
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler: @escaping () -> Void) {
        super.scaleTo(isEnlarge, completionHandler: completionHandler)
        if isEnlarge {
            player1TextField.isHidden = true
            player2TextField.isHidden = true
            leftServerView.isHidden = true
            rightServerView.isHidden = true
            isGoldenGoalLabel.isHidden = true
            isGoldenGoalConfigView.isHidden = true
            setConfigView.isHidden = true
            gameConfigView.isHidden = true
            surfaceConfigView.isHidden = true
        } else {
            player1TextField.isHidden = false
            player2TextField.isHidden = false
            leftServerView.isHidden = false
            rightServerView.isHidden = false
            isGoldenGoalLabel.isHidden = false
            isGoldenGoalConfigView.isHidden = false
            setConfigView.isHidden = false
            gameConfigView.isHidden = false
            surfaceConfigView.isHidden = false
        }
    }

    @objc func tapToUnfold(_ sender: TMPopUpView) {
        scaleTo(sender)
    }

    /// 返回用户填写的比赛数据
    /// - Returns: 0：player1LoginName，1: player2LoginName，2：setNum，3: gameNum， 4: isGoldenGoal
    func getData() -> (player1LoginName: String, player2LoginName: String, setNum: Int, gameNum: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool) {
//        let player1LoginName = player1TextField.textField.text ?? ""
//        let player2LoginName = player2TextField.textField.text ?? ""
//        let setNum = setConfigView.textField.text ?? "0"
//        let gameNum = gameConfigView.textField.text ?? "0"
//        let isGoldenGoal = isGoldenGoalConfigView.isOn
//        let isPlayer1Serving = isPlayer1Serving
//        return (player1LoginName, player2LoginName, Int(setNum)!, Int(gameNum)!, isGoldenGoal, isPlayer1Serving)
        return ("", "", 0, 0, true, true)
    }

    @objc func changeServe() {
        isPlayer1Serving.toggle()
        leftServerView.changeStats(to: isPlayer1Serving)
        rightServerView.changeStats(to: !isPlayer1Serving)
    }
}
