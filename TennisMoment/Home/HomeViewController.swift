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

class HomeViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate {
    var isRecordViewFullScreen = false

    /// 比赛记录视图
    lazy var recordView: TMRecordView = {
        var view = TMRecordView()
        view.setCorner(radii: 15)
        view.backgroundColor = UIColor(named: "ComponentBackground")
        return view
    }()

    lazy var configGameView: TMGameConfigView = {
        let view = TMGameConfigView()
        return view
    }()

    lazy var scheduleView: TMUserScheduleView = {
        let view = TMUserScheduleView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")
        view.backgroundColor = UIColor(named: "BackgroundGray")

        view.addSubview(recordView)
        view.addSubview(configGameView)
        view.addSubview(scheduleView)

        recordView.frame = CGRect(x: 24, y: 72, width: UIStandard.shared.screenWidth * 0.44, height: UIStandard.shared.screenHeight * 0.35)
        configGameView.frame = CGRect(x: 36 + recordView.bounds.width, y: 72, width: 68, height: 68)
        scheduleView.frame = CGRect(x: 24, y: 84 + UIStandard.shared.screenHeight * 0.35, width: 80 + UIStandard.shared.screenWidth * 0.44, height: UIStandard.shared.screenHeight * 0.44)

        recordView.setupUI()
        let tabAnimation = TABViewAnimated()
        tabAnimation.animatedColor = UIColor(named: "TennisBlur") ?? .gray
        recordView.tabAnimated = tabAnimation
        recordView.isUserInteractionEnabled = false
        recordView.tab_startAnimation {
            DispatchQueue.main.async {
                TMGameRequest.SearchRecentGames(playerId: TMUser.user.id, num: 1, isCompleted: false) { games in
                    if games.count == 1 {
                        self.recordView.setupEvent(game: games[0])
                        self.recordView.tab_endAnimationEaseOut()
                        self.recordView.isUserInteractionEnabled = true
                    } else {
                        self.recordView.setupAlart()
                        self.recordView.tab_endAnimationEaseOut()
                    }
                }
            }
        }

        configGameView.setupUI()
        configGameView.setupEvent(friends: TMUser.user.friends)
        recordView.addTapGesture(self, #selector(startRecord))

        configGameView.isHidden = false

        NotificationCenter.default.addObserver(self, selector: #selector(toastUp(_:)), name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: Notification.Name(ToastNotification.AddGAmeToast.notificationName.rawValue), object: nil)

        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)

        configGameView.setup(configGameView.bounds, configGameView.layer.position, CGRect(x: 100, y: 100, width: UIStandard.shared.screenWidth * 0.5, height: UIStandard.shared.screenHeight * 0.35), CGPoint(x: 36 + UIStandard.shared.screenWidth * 0.69, y: 72 + UIStandard.shared.screenHeight * 0.175), 0.3)

        scheduleView.setupUI()
    }

    @objc private func startRecord() {
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.backward"), style: .plain, target: self, action: #selector(endRecord)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(completeGame)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

        recordView.scaleTo(recordView.toggle, completionHandler: {})
        configGameView.isHidden = true
        scheduleView.isHidden = true
        recordView.refreshData()
    }

    @objc private func endRecord() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        recordView.saveGame()
        recordView.scaleTo(recordView.toggle, completionHandler: {
            self.configGameView.isHidden = false
            self.scheduleView.isHidden = false
        })
    }

    @objc private func completeGame() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        recordView.endGame {
            TMGameRequest.SearchRecentGames(playerId: TMUser.user.id, num: 1, isCompleted: false) { games in
                if games.count == 1 {
                    self.recordView.setupEvent(game: games[0])
                    self.recordView.scaleTo(self.recordView.toggle, completionHandler: {
                        self.configGameView.isHidden = false
                        self.scheduleView.isHidden = false
                    })
                    self.recordView.isUserInteractionEnabled = true
                } else {
                    self.recordView.scaleTo(self.recordView.toggle, completionHandler: {
                        self.configGameView.isHidden = false
                        self.scheduleView.isHidden = false
                        self.recordView.setupAlart()
                    })
                }
            }
        }

        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "LastGameTime")
    }

    @objc func toastUp(_ obj: Notification) {
        recordView.isUserInteractionEnabled = false
        let winner = obj.object as? String ?? ""
        let toastView = TMWinnerToastView()
        toastView.setupUI(winner)
        view.showToast(toastView, position: .center) { _ in
            self.completeGame()
            let vc = TMGameStatsDetailViewController()
            vc.game = self.recordView.game
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func startGame() {
        let gameConfig = configGameView.getData()
        var newGame = GameRequest(id: 0, place: "", surface: gameConfig.surfaceType, setNum: gameConfig.setNum, gameNum: gameConfig.gameNum, round: 0, isGoldenGoal: gameConfig.isGoldenGoal, isPlayer1Serving: gameConfig.isPlayer1Serving, isPlayer1Left: true, isChangePosition: false, startDate: Date().timeIntervalSince1970, endDate: nil, player1Id: gameConfig.player1Id, player1StatsId: 0, player2Id: gameConfig.player2Id, player2StatsId: 0, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[0, 0]]])
        TMUser.getLocationdescription(completionHandler: { location in
            newGame.place = location
            TMGameRequest.addGame(game: newGame) { game in
                guard let game = game else {
                    return
                }
                self.recordView.setNewGame(game: game)
                self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.backward"), style: .plain, target: self, action: #selector(self.endRecord)), animated: true)
                self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(self.completeGame)), animated: true)
                self.navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "ContentBackground")
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "ContentBackground")

                self.recordView.scaleTo(self.recordView.toggle, completionHandler: {})
                self.configGameView.isHidden = true
                self.scheduleView.isHidden = true
            }
        })
    }
}
