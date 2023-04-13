//
//  TMSettingInfoViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/7.
//

import Foundation
import TMComponent
import UIKit

class TMSettingInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var titleSettingConfig = ["Name", "Icon", "Sex", "Age", "YearsPlayed", "Height", "Width", "Grip", "Backhand"]
    var infoSettingConfig = [TMUser.user.name, "", TMUser.user.sex.rawValue, "\(TMUser.user.age)", "\(TMUser.user.yearsPlayed)", "\(TMUser.user.height)", "\(TMUser.user.width)", TMUser.user.grip.rawValue, TMUser.user.backhand.rawValue]
    let infoVC = TMSignUpViewController()

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(updateUserInfo)), animated: true)
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = UIColor(named: "BackgroundGray")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TMsettingTableViewCell.self, forCellReuseIdentifier: "TMsettingTableViewCell")
        infoVC.setUserInfo(name: TMUser.user.name, icon: TMUser.user.icon, sex: TMUser.user.sex, age: TMUser.user.age, yearsPlayed: TMUser.user.yearsPlayed, height: TMUser.user.height, width: TMUser.user.width, grip: TMUser.user.grip, backhand: TMUser.user.backhand)
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = TMSettingUserIconCell()
            let indexTitle = titleSettingConfig[indexPath.row]
            cell.setupEvent(title: indexTitle, icon: TMUser.user.icon)
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = TMsettingTableViewCell()
            let indexTitle = titleSettingConfig[indexPath.row]
            cell.setupEvent(title: indexTitle, info: infoSettingConfig[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        infoVC.showSubView(tag: indexPath.row + 200)
        infoVC.completionHandler = { result in
            (self.tableView.cellForRow(at: indexPath) as? TMsettingTableViewCell)?.setupEvent(title: self.titleSettingConfig[indexPath.row], info: result)
        }
        navigationController?.pushViewController(infoVC, animated: true)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        98
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        titleSettingConfig.count
    }

    @objc func cancel() {
        let sheetCtrl = UIAlertController(title: "Cancel changes", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        sheetCtrl.addAction(action)

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            sheetCtrl.dismiss(animated: true)
        }
        sheetCtrl.addAction(cancelAction)

        sheetCtrl.popoverPresentationController?.sourceView = view
        sheetCtrl.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.width / 2 - 144, y: view.bounds.height / 2 - 69, width: 288, height: 138)
        present(sheetCtrl, animated: true, completion: nil)
    }

    @objc func updateUserInfo() {
        let sheetCtrl = UIAlertController(title: "Cancel changes", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.infoVC.getUserInfo()
            TMUser.updateInfo { _ in
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.DataFreshToast.notificationName.rawValue), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
        sheetCtrl.addAction(action)

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            sheetCtrl.dismiss(animated: true)
        }
        sheetCtrl.addAction(cancelAction)

        sheetCtrl.popoverPresentationController?.sourceView = view
        sheetCtrl.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.width / 2 - 144, y: view.bounds.height / 2 - 69, width: 288, height: 138)
        present(sheetCtrl, animated: true, completion: nil)
    }
}
