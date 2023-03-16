//
//  HomeViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import CoreLocation
import Foundation
import SwiftyJSON
import TABAnimated
import TMComponent
import Toast_Swift
import UIKit

/// 首页V1
class HomeViewController: UIViewController, CLLocationManagerDelegate {
    var isRecordViewFullScreen = false

    /// 比赛记录视图
    lazy var recordView: TMRecordView = {
        var view = TMRecordView()
        view.setCorner(radii: 15)
        view.backgroundColor = UIColor(named: "ComponentBackground")
        return view
    }()

    lazy var NewGameBtn: TMTitleOrImageButton = {
        let button = TMTitleOrImageButton()
        button.backgroundColor = UIColor(named: "ComponentBackground")
        return button
    }()

    lazy var configGameView: TMGameConfigView = {
        let view = TMGameConfigView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        view.backgroundColor = UIColor(named: "BackgroundGray")
        navigationItem.hidesBackButton = true

        view.addSubview(recordView)
        view.addSubview(configGameView)
        view.addSubview(NewGameBtn)

        recordView.frame = CGRect(x: 24, y: 72, width: UIStandard.shared.screenWidth * 0.44, height: UIStandard.shared.screenHeight * 0.35)
        configGameView.frame = CGRect(x: 36 + recordView.bounds.width, y: 72, width: 100, height: 100)
        NewGameBtn.frame = CGRect(x: 36 + recordView.bounds.width, y: 72, width: 100, height: 100)

        recordView.setupUI()
        let tabAnimation = TABViewAnimated()
        tabAnimation.animatedColor = UIColor(named: "TennisBlur") ?? .gray
        recordView.tabAnimated = tabAnimation
        recordView.tab_startAnimation {
            DispatchQueue.main.async {
                TMGameRequest.SearchRecentGames(playerLoginName: TMUser.user.loginName, num: 1) { gameAndStats in
                    if gameAndStats.datas.count == 1 {
                        self.recordView.setupEvent(game: gameAndStats.datas[0].game)
                        self.recordView.tab_endAnimationEaseOut()
                    } else {
                        self.recordView.setupAlart()
                        self.recordView.tab_endAnimationEaseOut()
                    }
                }
            }
        }

        configGameView.setupUI()
        configGameView.setupEvent(friends: players)

        NewGameBtn.addTapGesture(self, #selector(configGameViewUp))
        recordView.addTapGesture(self, #selector(startRecord))

        let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
        NewGameBtn.setUp(with: config)

        configGameView.isHidden = false
        NewGameBtn.isHidden = false

        NotificationCenter.default.addObserver(self, selector: #selector(toastUp(_:)), name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: nil)

        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)

        configGameView.setup(configGameView.bounds, configGameView.layer.position, CGRect(x: 100, y: 100, width: UIStandard.shared.screenWidth * 0.5, height: UIStandard.shared.screenHeight * 0.3), CGPoint(x: 36 + UIStandard.shared.screenWidth * 0.69, y: 72 + UIStandard.shared.screenHeight * 0.15), 0.3)
    }

    @objc private func startRecord() {
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.backward"), style: .plain, target: self, action: #selector(endRecord)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(completeGame)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

        recordView.scaleTo(recordView.toggle, completionHandler: {})
        configGameView.isHidden = true
        NewGameBtn.isHidden = true
        recordView.refreshData()
    }

    @objc private func endRecord() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        recordView.saveGame(isCompleted: false)
        recordView.scaleTo(recordView.toggle, completionHandler: {
            self.configGameView.isHidden = false
            self.NewGameBtn.isHidden = false
        })
    }

    @objc private func completeGame() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        recordView.saveGame(isCompleted: true)
        recordView.scaleTo(recordView.toggle, completionHandler: {
            self.configGameView.isHidden = false
            self.NewGameBtn.isHidden = false
        })
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "LastGameTime")
    }

    @objc func toastUp(_ obj: Notification) {
        let winner = obj.object as? String ?? ""
        let toastView = TMWinnerToastView()
        toastView.setupUI(winner)
        view.showToast(toastView, position: .center)
    }

    @objc func configGameViewUp() {
        configGameView.scaleTo(configGameView.toggle, completionHandler: {})

        let config = TMTitleOrImageButtonConfig(title: "START", action: #selector(startGame), actionTarget: self)
        NewGameBtn.setUp(with: config)
    }

    @objc func startGame() {
        let gameConfig = configGameView.getData()
        var newGame = Game(date: Date().timeIntervalSince1970, place: "", surface: .hard, setNum: gameConfig.setNum, gameNum: gameConfig.gameNum, isGoldenGoal: gameConfig.isGoldenGoal, isPlayer1Serving: gameConfig.isPlayer1Serving, isPlayer1Left: true, isChangePosition: false, isCompleted: false, player1LoginName: gameConfig.player1LoginName, player1StatsId: 0, player2LoginName: gameConfig.player2LoginName, player2StatsId: 0, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[0, 0]]])
        TMLocationManager.shared.startPositioning { location in
            newGame.place = location
            TMGameRequest.addGame(game: newGame) { [weak self] game in
                guard let self = self else {
                    return
                }
                guard let game = game else {
                    return
                }
                self.configGameView.scaleTo(self.configGameView.toggle, completionHandler: {})
                let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(self.configGameViewUp), actionTarget: self)
                self.NewGameBtn.setUp(with: config)
                self.recordView.setNewGame(game: game)

                self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.backward"), style: .plain, target: self, action: #selector(self.endRecord)), animated: true)
                self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(self.completeGame)), animated: true)
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

                self.recordView.scaleTo(self.recordView.toggle, completionHandler: {})
                self.configGameView.isHidden = true
                self.NewGameBtn.isHidden = true
            }
        }
    }
}
