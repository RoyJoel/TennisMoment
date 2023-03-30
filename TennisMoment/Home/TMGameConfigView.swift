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
    let player1Selections = Player1SelectViewDataSource()
    let player2Selections = Player1SelectViewDataSource()
    let setNumSelections = setNumSelectViewDataSource()
    let gameNumSelections = gameNumSelectViewDataSource()
    let surfaceTypeSelections = surfaceTypeConfigViewDataSource()
    var isPlayer1Serving: Bool = true

    lazy var startGameBtn: TMTitleOrImageButton = {
        let btn = TMTitleOrImageButton()
        return btn
    }()

    lazy var Player1SelectView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    lazy var Player2SelectView: TMPopUpView = {
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
        addSubview(Player1SelectView)
        addSubview(Player2SelectView)
        addSubview(leftServerView)
        addSubview(rightServerView)
        addSubview(isGoldenGoalLabel)
        addSubview(isGoldenGoalConfigView)
        addSubview(setConfigView)
        addSubview(gameConfigView)
        addSubview(surfaceConfigView)

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        Player1SelectView.frame = CGRect(x: 220, y: 112, width: UIStandard.shared.screenWidth * 0.15, height: 44)
        Player2SelectView.frame = CGRect(x: 480, y: 112, width: UIStandard.shared.screenWidth * 0.15, height: 44)

        leftServerView.frame = CGRect(x: 170 + UIStandard.shared.screenWidth * 0.075, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)
        rightServerView.frame = CGRect(x: 430 + UIStandard.shared.screenWidth * 0.075, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)

        isGoldenGoalLabel.frame = CGRect(x: 214 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 30)

        isGoldenGoalConfigView.frame = CGRect(x: 234 + UIStandard.shared.screenWidth * 0.15, y: 154 + UIStandard.shared.screenHeight * 0.08, width: 100, height: 50)

        setConfigView.frame = CGRect(x: 116, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: 30)

        gameConfigView.frame = CGRect(x: 128 + UIStandard.shared.screenWidth * 0.15, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: 30)

        surfaceConfigView.frame = CGRect(x: 140 + UIStandard.shared.screenWidth * 0.3, y: 208 + UIStandard.shared.screenHeight * 0.08, width: UIStandard.shared.screenWidth * 0.15, height: 30)

        Player1SelectView.isHidden = true
        Player2SelectView.isHidden = true
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
        bringSubviewToFront(Player1SelectView)
        bringSubviewToFront(Player2SelectView)

        let startGameBtnConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
        startGameBtn.setUp(with: startGameBtnConfig)

        Player1SelectView.delegate = Player1SelectView
        Player2SelectView.delegate = Player2SelectView
        setConfigView.delegate = setConfigView
        gameConfigView.delegate = gameConfigView
        surfaceConfigView.delegate = surfaceConfigView

        leftServerView.setup(isServing: isPlayer1Serving)
        rightServerView.setup(isServing: !isPlayer1Serving)

        isGoldenGoalLabel.text = "GoldenGoal"
        isGoldenGoalLabel.textAlignment = .center

        leftServerView.addTapGesture(self, #selector(changeServe))
        rightServerView.addTapGesture(self, #selector(changeServe))
    }

    func setupEvent(friends: [Player]) {
        player1Selections.players = friends
        player2Selections.players = friends
        Player1SelectView.dataSource = player1Selections
        Player2SelectView.dataSource = player2Selections
        setConfigView.dataSource = setNumSelections
        gameConfigView.dataSource = gameNumSelections
        surfaceConfigView.dataSource = surfaceTypeSelections
        Player1SelectView.setupUI()
        Player2SelectView.setupUI()
        setConfigView.setupUI()
        gameConfigView.setupUI()
        surfaceConfigView.setupUI()
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
        if !toggle {
            startGameBtn.addAnimation(startGameBtn.layer.position, CGPoint(x: 136, y: 136), 0.3, "position")
            startGameBtn.layer.position = CGPoint(x: 136, y: 136)
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "figure.table.tennis")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
        } else {
            Player1SelectView.isHidden = true
            Player2SelectView.isHidden = true
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
        }
        super.scaleTo(isEnlarge) {
            if self.toggle {
                self.Player1SelectView.isHidden = false
                self.Player2SelectView.isHidden = false
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
        let player1Id = player1Selections.players[Player1SelectView.selectedIndex?.row ?? 0].id
        let player2Id = player2Selections.players[Player2SelectView.selectedIndex?.row ?? 0].id
        let setConfig = setNumSelections.numConfig[setConfigView.selectedIndex?.row ?? 0]
        let gameConfig = gameNumSelections.numConfig[gameConfigView.selectedIndex?.row ?? 0]
        let surfaceConfig = surfaceTypeSelections.surfaceConfig[surfaceConfigView.selectedIndex?.row ?? 0].rawValue
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

class Player1SelectViewDataSource: NSObject, UITableViewDataSource {
    var players: [Player] = []

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMplayerSelectionCell()
        cell.setupUI()
        cell.setupEvent(imageName: players[indexPath.row].icon, playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
        return cell
    }
}

class Player2SelectViewDataSource: NSObject, UITableViewDataSource {
    var players: [Player] = []

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMplayerSelectionCell()
        cell.setupUI()
        cell.setupEvent(imageName: players[indexPath.row].icon, playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
        return cell
    }
}

class setNumSelectViewDataSource: NSObject, UITableViewDataSource {
    var numConfig: [Int] = [1, 2, 3]
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        numConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: "\(numConfig[indexPath.row])")
        return cell
    }
}

class gameNumSelectViewDataSource: NSObject, UITableViewDataSource {
    var numConfig: [Int] = [4, 6]
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        numConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: "\(numConfig[indexPath.row])")
        return cell
    }
}

class surfaceTypeConfigViewDataSource: NSObject, UITableViewDataSource {
    var surfaceConfig: [SurfaceType] = [.hard, .clay, .grass]

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        surfaceConfig.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPopUpCell()
        cell.setupUI()
        cell.setupEvent(title: surfaceConfig[indexPath.row].rawValue)
        return cell
    }
}
