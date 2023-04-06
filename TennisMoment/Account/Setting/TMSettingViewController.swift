//
//  TMSettingViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/30.
//

import Foundation
import TMComponent
import UIKit

class TMSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var settingConfig = ["Appearance": [AppearanceSetting.Light.userDisplayName, AppearanceSetting.Dark.userDisplayName, AppearanceSetting.UnSpecified.userDisplayName], "Language": [LanguageSetting.Ch.userDisplayName, LanguageSetting.En.userDisplayName, LanguageSetting.Es.userDisplayName, LanguageSetting.De.userDisplayName, LanguageSetting.Fr.userDisplayName], "Info": [""]]
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var signOutBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(tableView)
        view.addSubview(signOutBtn)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(signOutBtn.snp.top).offset(-5)
        }
        signOutBtn.snp.makeConstraints { make in
            make.width.equalTo(68)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        tableView.backgroundColor = UIColor(named: "BackgroundGray")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TMsettingTableViewCell.self, forCellReuseIdentifier: "TMsettingTableViewCell")
        let signOutBtnConfig = TMButtonConfig(title: "Sign Out", action: #selector(signOut), actionTarget: self)
        signOutBtn.setupUI()
        signOutBtn.setupEvent(config: signOutBtnConfig)
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = TMSettingIconCell()
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        } else if indexPath.row == 1 {
            let cell = TMsettingTableViewCell()
            cell.setupEvent(title: "Appearance", info: Bundle.main.object(forInfoDictionaryKey: "UIUserInterfaceStyle") as? String ?? "Set Appearance")
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 2 {
            let cell = TMsettingTableViewCell()
            cell.setupEvent(title: "Language", info: UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese")
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = TMsettingTableViewCell()
            cell.setupEvent(title: "Info", info: "")
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TMsettingTableViewCell
        let vc = TMSettingSelectionViewController()
        vc.title = cell.titleView.text
        let configs = ["Appearance", "Language", "Info"]
        vc.dataSource = settingConfig[configs[indexPath.row - 1]] ?? []
        vc.completionHandler = { result in
            if indexPath.row == 1 {
                cell.setupEvent(title: "Appearance", info: result)
            } else if indexPath.row == 2 {
                cell.setupEvent(title: "Language", info: result)
            }
        }
        present(vc, animated: true)
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 362
        } else {
            return 98
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        4
    }

    @objc func signOut() {
        if let window = signOutBtn.window {
            UserDefaults.standard.set(nil, forKey: TMUDKeys.JSONWebToken.rawValue)
            window.rootViewController = TMSignInViewController()
        }
    }
}
