//
//  TMPlayerSearchingView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/10.
//

import Foundation
import TMComponent
import UIKit

class TMPlayerSearchingView: TMView, UISearchBarDelegate {
    var viewUpCompletionHandler: () -> Void = {}

    lazy var startGameBtn: TMTitleOrImageButton = {
        let btn = TMTitleOrImageButton()
        return btn
    }()

    lazy var playerSearchBar: UISearchBar = {
        let button = UISearchBar()
        return button
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "ComponentBackground")
        setCorner(radii: 15)
        clipsToBounds = false

        addSubview(startGameBtn)
        addSubview(playerSearchBar)

        startGameBtn.frame = CGRect(x: 0, y: 0, width: 68, height: 68)
        playerSearchBar.frame = CGRect(x: 120, y: 12, width: UIStandard.shared.screenWidth * 0.15, height: 44)

        playerSearchBar.isHidden = true

        let startGameBtnConfig = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(gameSearchingViewUp), actionTarget: self)
        startGameBtn.setUp(with: startGameBtnConfig)

        playerSearchBar.placeholder = NSLocalizedString("Search", comment: "")
        playerSearchBar.searchBarStyle = .minimal
        playerSearchBar.delegate = self
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler _: @escaping () -> Void) {
        if !toggle {
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(startGame), actionTarget: self)
            startGameBtn.setUp(with: config)
        } else {
            playerSearchBar.isHidden = true
            let config = TMTitleOrImageButtonConfig(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), action: #selector(gameSearchingViewUp), actionTarget: self)
            startGameBtn.setUp(with: config)
        }
        super.scaleTo(isEnlarge) {
            if self.toggle {
                self.viewUpCompletionHandler()
                self.playerSearchBar.isHidden = false
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
    func getData() -> String? {
        playerSearchBar.text
    }

    // 实现 UISearchBarDelegate 协议中的 searchBarSearchButtonClicked 方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 获取搜索栏中的文本
        let searchText = searchBar.text ?? ""

        TMPlayerRequest.getInfo(loginName: searchText) { _ in
        }
    }

    @objc func gameSearchingViewUp() {
        scaleTo(toggle, completionHandler: {})
    }

    @objc func startGame() {
        NotificationCenter.default.post(name: Notification.Name(ToastNotification.AddGAmeToast.notificationName.rawValue), object: nil)
    }
}
