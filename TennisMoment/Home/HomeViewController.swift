//
//  HomeViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import CoreLocation
import Foundation
import SwiftyJSON
import TMComponent
import Toast_Swift
import UIKit

/// 首页V1
class HomeViewController: UIViewController, CLLocationManagerDelegate {
    var isRecordViewFullScreen = false
    var homeViewAttributeTitle: NSMutableAttributedString = .init(string: "")

    /// 导航栏标题
    lazy var titleView: UILabel = {
        var label = UILabel()
        label.attributedText = homeViewAttributeTitle
        return label
    }()

    /// 比赛记录视图
    lazy var recordView: TMRecordView = {
        var view = TMRecordView()
        view.backgroundColor = UIColor(named: "TennisBlur")
        view.setCorner(radii: 15)
        return view
    }()

    lazy var NewGameBtn: TMTitleOrImageButton = {
        let button = TMTitleOrImageButton()
        return button
    }()

    lazy var configGameView: TMGameConfigView = {
        let view = TMGameConfigView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewAttributeTitle = .init(string: "Home")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.titleView = titleView
        navigationItem.hidesBackButton = true

        view.addSubview(recordView)
        view.addSubview(configGameView)
        view.addSubview(NewGameBtn)

        recordView.frame = CGRect(x: 24, y: 72, width: UIStandard.shared.screenWidth * 0.44, height: UIStandard.shared.screenHeight * 0.35)
        configGameView.frame = CGRect(x: 36 + recordView.bounds.width, y: 72, width: 100, height: 100)
        NewGameBtn.frame = CGRect(x: 36 + recordView.bounds.width, y: 72, width: 100, height: 100)

        recordView.setupUI()
        DispatchQueue.global(qos: .userInitiated).async {
            TMGameRequest.searchAllGames(for: "jasony") { games in
                if games.count > 0 {
                    let game = games.first!
                    self.recordView.setupEvent(game: game)
                } else {
                    // 配置record view新内容，还没想好
                }
            }
        }

        configGameView.setupUI()

        NewGameBtn.addTapGesture(self, #selector(configGameViewUp))
        recordView.addTapGesture(self, #selector(startRecord))

        let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(configGameViewUp), actionTarget: self)
        NewGameBtn.setUp(with: config)

        configGameView.isHidden = false
        NewGameBtn.isHidden = false

        NotificationCenter.default.addObserver(self, selector: #selector(toastUp(_:)), name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(addGame(_:)), name: Notification.Name(ToastNotification.AddGAmeToast.notificationName.rawValue), object: nil)
    }

    @objc private func startRecord() {
        homeViewAttributeTitle = .init(string: "Record")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(endRecord)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "stop"), style: .plain, target: self, action: #selector(completeGame)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = .black

        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)

        recordView.scaleTo(recordView.toggle)

        configGameView.isHidden = true
        NewGameBtn.isHidden = true
    }

    @objc private func endRecord() {
        homeViewAttributeTitle = .init(string: "Home")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.leftBarButtonItem = nil

        recordView.scaleTo(recordView.toggle)
        recordView.saveGame(isCompleted: false)

        configGameView.isHidden = false
        NewGameBtn.isHidden = false
    }

    @objc private func completeGame() {
        homeViewAttributeTitle = .init(string: "Home")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.leftBarButtonItem = nil

        recordView.scaleTo(recordView.toggle)

        recordView.saveGame(isCompleted: true)

        configGameView.isHidden = false
        NewGameBtn.isHidden = false
    }

    @objc func toastUp(_ obj: Notification) {
        let winner = obj.object as? String ?? ""
        let toastView = TMWinnerToastView()
        toastView.setupUI(winner)
        view.showToast(toastView, position: .center)
    }

    @objc func configGameViewUp() {
        configGameView.setup(configGameView.bounds, configGameView.layer.position, CGRect(x: 100, y: 100, width: UIStandard.shared.screenWidth * 0.5, height: UIStandard.shared.screenHeight * 0.3), CGPoint(x: 36 + UIStandard.shared.screenWidth * 0.69, y: 72 + UIStandard.shared.screenHeight * 0.15), 0.3)
        configGameView.scaleTo(configGameView.toggle)

        let config = TMTitleOrImageButtonConfig(title: "START", action: #selector(startGame), actionTarget: self)
        NewGameBtn.setUp(with: config)
    }

    @objc func startGame() {
        let gameConfig = configGameView.getData()
        let newGame = Game(date: 0, place: "", surface: .hard, setNum: gameConfig.setNum, gameNum: gameConfig.gameNum, isGoldenGoal: gameConfig.isGoldenGoal, isPlayer1Serving: gameConfig.isPlayer1Serving, isCompleted: false, player1LoginName: gameConfig.player1LoginName, player1StatsId: 0, player2LoginName: gameConfig.player2LoginName, player2StatsId: 0, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[0, 0]]])
        TMGameRequest.addGame(game: newGame) { result in
            if result {
                self.configGameView.scaleTo(self.configGameView.toggle)
                let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(self.configGameViewUp), actionTarget: self)
                self.NewGameBtn.setUp(with: config)
                self.recordView.setupEvent(game: newGame)
            } else {}
        }
    }
}
