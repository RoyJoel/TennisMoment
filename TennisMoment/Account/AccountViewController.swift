//
//  AccountViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import SwiftyJSON
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = UIColor(named: "ContentBackground")

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
                TMGameRequest.SearchRecentGames(playerId: TMUser.user.id, num: 3, isCompleted: true) { games in
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
        userDataView.gameStatsView.leftActivityView.addTapGesture(self, #selector(enterLeftDetailStatsView))
        userDataView.gameStatsView.midActivityView.addTapGesture(self, #selector(enterMidDetailStatsView))
        userDataView.gameStatsView.rightActivityView.addTapGesture(self, #selector(enterRightDetailStatsView))
        settingView.isUserInteractionEnabled = true
        settingView.addTapGesture(self, #selector(settingViewUp))
    }

    @objc func enterLeftDetailStatsView() {
        let vc = TMGameStatsDetailViewController()
        vc.game = userDataView.gameStatsView.leftActivityView.game ?? Game(json: JSON())
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func enterMidDetailStatsView() {
        let vc = TMGameStatsDetailViewController()
        vc.game = userDataView.gameStatsView.midActivityView.game ?? Game(json: JSON())
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func enterRightDetailStatsView() {
        let vc = TMGameStatsDetailViewController()
        vc.game = userDataView.gameStatsView.rightActivityView.game ?? Game(json: JSON())
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func settingViewUp() {
        let vc = TMSettingViewController()
        navigationController?.present(vc, animated: true)
    }
}
