//
//  GameConfigToast.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import TMComponent
import UIKit

class TMGameConfigView: TMUserInteractionUnabledView, UITableViewDelegate {
    var isPlayer1Serving: Bool = true

    lazy var startGameBtn: TMTitleOrImageButton = {
        let btn = TMTitleOrImageButton()
        return btn
    }()

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

        addSubview(startGameBtn)
        addSubview(player1TextField)
        addSubview(player2TextField)
        addSubview(leftServerView)
        addSubview(rightServerView)
        addSubview(isGoldenGoalLabel)
        addSubview(isGoldenGoalConfigView)
        addSubview(setConfigView)
        addSubview(gameConfigView)
        addSubview(surfaceConfigView)

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        player1TextField.frame = CGRect(x: 220, y: 112, width: UIStandard.shared.screenWidth * 0.15, height: 44)
        player2TextField.frame = CGRect(x: 480, y: 112, width: UIStandard.shared.screenWidth * 0.15, height: 44)

        leftServerView.frame = CGRect(x: 170 + UIStandard.shared.screenWidth * 0.075, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)
        rightServerView.frame = CGRect(x: 430 + UIStandard.shared.screenWidth * 0.075, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)

        isGoldenGoalLabel.frame = CGRect(x: 214 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 30)

        isGoldenGoalConfigView.frame = CGRect(x: 234 + UIStandard.shared.screenWidth * 0.15, y: 154 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)

        setConfigView.frame = CGRect(x: 116, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: 30)

        gameConfigView.frame = CGRect(x: 128 + UIStandard.shared.screenWidth * 0.15, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: 30)

        surfaceConfigView.frame = CGRect(x: 140 + UIStandard.shared.screenWidth * 0.3, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: 30)

        player1TextField.isHidden = true
        player2TextField.isHidden = true
        leftServerView.isHidden = true
        rightServerView.isHidden = true
        isGoldenGoalLabel.isHidden = true
        isGoldenGoalConfigView.isHidden = true
        setConfigView.isHidden = true
        gameConfigView.isHidden = true
        surfaceConfigView.isHidden = true

        bringSubviewToFront(setConfigView)
        bringSubviewToFront(gameConfigView)
        bringSubviewToFront(surfaceConfigView)
        bringSubviewToFront(player1TextField)
        bringSubviewToFront(player2TextField)

        let startGameBtnConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
        startGameBtn.setUp(with: startGameBtnConfig)

        player1TextField.delegate = player1TextField
        player2TextField.delegate = player2TextField
        setConfigView.delegate = setConfigView
        gameConfigView.delegate = gameConfigView
        surfaceConfigView.delegate = surfaceConfigView

        leftServerView.setup(isServing: isPlayer1Serving)
        rightServerView.setup(isServing: !isPlayer1Serving)

        isGoldenGoalLabel.text = "GoldenGoal"
        isGoldenGoalLabel.textAlignment = .center

        leftServerView.addTapGesture(self, #selector(changeServe))
        rightServerView.addTapGesture(self, #selector(changeServe))

        player1TextField.setupUI()
        player2TextField.setupUI()
        setConfigView.setupUI()
        gameConfigView.setupUI()
        surfaceConfigView.setupUI()
    }

    func setupEvent(friends: [Player]) {
        var playerCells: [TMplayerSelectionCell] = []
        for friend in friends {
            let cell = TMplayerSelectionCell()
            cell.setup()
            cell.setupEvent(imageName: friend.icon, playerName: friend.name, playerId: friend.id)
            playerCells.append(cell)
        }
        var player2Cells: [TMplayerSelectionCell] = []
        for friend in friends {
            let cell = TMplayerSelectionCell()
            cell.setup()
            cell.setupEvent(imageName: friend.icon, playerName: friend.name, playerId: friend.id)
            player2Cells.append(cell)
        }
        let player1TextFieldconfig = TMPopUpViewConfig(cells: playerCells, rowHeight: 44)
        let player2TextFieldconfig = TMPopUpViewConfig(cells: player2Cells, rowHeight: 44)
        player1TextField.setupEvent(config: player1TextFieldconfig)
        player2TextField.setupEvent(config: player2TextFieldconfig)

        var setConfigCells: [TMPopUpViewCell] = []
        for i in 1 ... 6 {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: "\(i)")
            setConfigCells.append(cell)
        }
        let setConfig = TMPopUpViewConfig(cells: setConfigCells, rowHeight: 30)
        setConfigView.setupEvent(config: setConfig)

        var gameConfigCells: [TMPopUpViewCell] = []
        for i in 1 ... 6 {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: "\(i)")
            gameConfigCells.append(cell)
        }
        let gameConfig = TMPopUpViewConfig(cells: gameConfigCells, rowHeight: 30)
        gameConfigView.setupEvent(config: gameConfig)

        var surfaceConfigCells: [TMPopUpViewCell] = []
        for surface in SurfaceType.allCases {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: surface.rawValue)
            surfaceConfigCells.append(cell)
        }
        let surfaceConfig = TMPopUpViewConfig(cells: surfaceConfigCells, rowHeight: 30)
        surfaceConfigView.setupEvent(config: surfaceConfig)
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
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
            startGameBtn.addAnimation(startGameBtn.layer.position, CGPoint(x: 34, y: 34), 0.3, "position")
            startGameBtn.layer.position = CGPoint(x: 34, y: 34)
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
        } else {
            startGameBtn.addAnimation(startGameBtn.layer.position, CGPoint(x: 136, y: 136), 0.3, "position")
            startGameBtn.layer.position = CGPoint(x: 136, y: 136)
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "figure.table.tennis")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
        }
        super.scaleTo(isEnlarge) {
            if !isEnlarge {
                self.player1TextField.isHidden = false
                self.player2TextField.isHidden = false
                self.leftServerView.isHidden = false
                self.rightServerView.isHidden = false
                self.isGoldenGoalLabel.isHidden = false
                self.isGoldenGoalConfigView.isHidden = false
                self.setConfigView.isHidden = false
                self.gameConfigView.isHidden = false
                self.surfaceConfigView.isHidden = false
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.point(inside: point, with: nil), toggle == true {
            scaleTo(toggle, completionHandler: {})
        }
        return super.hitTest(point, with: event)
    }

    /// 返回用户填写的比赛数据
    /// - Returns: 0：player1LoginName，1: player2LoginName，2：setNum，3: gameNum， 4: isGoldenGoal
    func getData() -> (player1Id: Int, player2Id: Int, surfaceType: SurfaceType, setNum: Int, gameNum: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool) {
        let player1Id = (player1TextField.config.cells.first as! TMplayerSelectionCell).playerId
        let player2Id = (player2TextField.config.cells.first as! TMplayerSelectionCell).playerId
        let setConfig = Int((setConfigView.config.cells.first as! TMPopUpViewCell).label.text ?? "0") ?? 0
        let gameConfig = Int((gameConfigView.config.cells.first as! TMPopUpViewCell).label.text ?? "0") ?? 0
        let surfaceConfig = (surfaceConfigView.config.cells.first as! TMPopUpViewCell).label.text ?? "hard"
        return (player1Id, player2Id, SurfaceType(rawValue: surfaceConfig) ?? .hard, setConfig, gameConfig, isGoldenGoalConfigView.isOn, isPlayer1Serving)
    }

    @objc func configGameViewUp() {
        scaleTo(toggle, completionHandler: {})
    }

    @objc func startGame() {
        scaleTo(toggle, completionHandler: {})
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.AddGAmeToast.notificationName.rawValue), object: nil)
    }

    @objc func changeServe() {
        isPlayer1Serving.toggle()
        leftServerView.changeStats(to: isPlayer1Serving)
        rightServerView.changeStats(to: !isPlayer1Serving)
    }
}
