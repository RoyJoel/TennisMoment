//
//  TMGameSearchingView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/10.
//

import Foundation
import TMComponent
import UIKit

class TMGameSearchingView: TMView, UITableViewDataSource {
    var players: [Player] = []
    var viewUpCompletionHandler: () -> Void = {}
    lazy var startGameBtn: TMTitleOrImageButton = {
        let btn = TMTitleOrImageButton()
        return btn
    }()

    lazy var Player1SelectView: TMPopUpView = {
        let textField = TMPopUpView()
        return textField
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        clipsToBounds = false

        addSubview(startGameBtn)
        addSubview(Player1SelectView)

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        Player1SelectView.frame = CGRect(x: 120, y: 12, width: UIStandard.shared.screenWidth * 0.15, height: 44)

        Player1SelectView.isHidden = true

        let startGameBtnConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "clock")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(gameSearchingViewUp), actionTarget: self)
        startGameBtn.setUp(with: startGameBtnConfig)

        Player1SelectView.delegate = Player1SelectView
    }

    func setupEvent(friends: [Player]) {
        players = friends
        Player1SelectView.dataSource = self
        Player1SelectView.setupUI()
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
        if !toggle {
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
        } else {
            Player1SelectView.isHidden = true
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "clock")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(gameSearchingViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
        }
        super.scaleTo(isEnlarge) {
            if self.toggle {
                self.viewUpCompletionHandler()
                self.Player1SelectView.isHidden = false
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
    func getData() -> Int {
        players[Player1SelectView.selectedIndex?.row ?? 0].id
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        players.count == 0 ? 1 : players.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if players.count == 0 {
            let cell = TMPopUpCell()
            cell.setupUI()
            cell.setupEvent(title: "Find a friend To Play With")
            return cell
        } else {
            let cell = TMplayerSelectionCell()
            cell.setupEvent(imageName: players[indexPath.row].icon, playerName: players[indexPath.row].name, playerId: players[indexPath.row].id)
            return cell
        }
    }

    @objc func gameSearchingViewUp() {
        scaleTo(toggle, completionHandler: {})
    }

    @objc func startGame() {
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.AddGAmeToast.notificationName.rawValue), object: nil)
    }
}
