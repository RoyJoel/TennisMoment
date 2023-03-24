//
//  AccountViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import TMComponent
import UIKit

class AccountViewController: UIViewController {
    var games: [Game] = []

    lazy var settingView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape")
        return imageView
    }()

    lazy var iconView: TMIconView = {
        let iconView = TMIconView()
        return iconView
    }()

    lazy var basicInfoView: TMUserInfoView = {
        let infoView = TMUserInfoView()
        return infoView
    }()

    lazy var userDataView: TMUserDataView = {
        let dataView = TMUserDataView()
        return dataView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = ""
        view.backgroundColor = UIColor(named: "BackgroundGray")

        view.addSubview(settingView)
        view.addSubview(iconView)
        view.addSubview(basicInfoView)
        view.addSubview(userDataView)

        iconView.setupUI()
        basicInfoView.setupUI()
        let iconConfig = TMIconViewConfig(icon: TMUser.user.icon, name: TMUser.user.name)
        iconView.setupEvent(config: iconConfig)
        basicInfoView.setupEvent()
        userDataView.setupUI()
        userDataView.setupEventForCareerStatsView()

        userDataView.tab_startAnimation {
            DispatchQueue.main.async {
                TMGameRequest.SearchRecentGames(playerId: TMUser.user.id, num: 3) { games in
                    self.games = games
                    if self.games.count != 0 {
                        self.userDataView.setupEventForGameStatsView(games: self.games)
                    } else {
                        self.userDataView.gameStatsView.setupAlart()
                    }
                }
            }
        }
        settingView.tintColor = UIColor(named: "ContentBackground")
        settingView.snp.makeConstraints { make in
            make.top.equalTo(32)
            make.left.equalTo(44)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        iconView.snp.makeConstraints { make in
            make.top.equalTo(settingView.snp.bottom).offset(24)
            make.left.equalTo(settingView.snp.left).offset(40)
            make.width.equalTo(164)
            make.height.equalTo(240)
        }
        basicInfoView.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(40)
            make.top.equalTo(iconView.snp.top).offset(-68)
            make.right.equalToSuperview().offset(-44)
            make.bottom.equalTo(iconView.snp.bottom).offset(22)
        }
        userDataView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(44)
            make.right.equalToSuperview().offset(-44)
            make.top.equalTo(iconView.snp.bottom)
            make.bottom.equalToSuperview().offset(-78)
        }
    }
}
