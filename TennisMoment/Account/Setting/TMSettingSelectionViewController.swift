//
//  TMSettingSelectionViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/31.
//

import Foundation
import TMComponent
import UIKit

class TMSettingSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedRow: Int?
    var dataSource: [String] = []
    var completionHandler: (String) -> Void = { _ in }
    lazy var selectionTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(selectionTableView)
        selectionTableView.backgroundColor = UIColor(named: "BackgroundGray")
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
        selectionTableView.register(TMSettingSelectionCell.self, forCellReuseIdentifier: "TMSettingSelectionCell")
        selectionTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        dataSource.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        118
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if title == "Language" {
            let selectedLanguage = dataSource[indexPath.row]
            let message = "Change language of this app including its content."
            let sheetCtrl = UIAlertController(title: "Change language", message: message, preferredStyle: .alert)

            let action = UIAlertAction(title: "Ok", style: .default) { _ in
                self.changeToLanguage(languageCode: selectedLanguage)
                self.select(at: indexPath)
            }
            sheetCtrl.addAction(action)

            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
                sheetCtrl.dismiss(animated: true)
            }
            sheetCtrl.addAction(cancelAction)

            sheetCtrl.popoverPresentationController?.sourceView = view
            sheetCtrl.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.width / 2 - 144, y: view.bounds.height / 2 - 69, width: 288, height: 138)
            present(sheetCtrl, animated: true, completion: nil)
            completionHandler(selectedLanguage)
        } else if title == "Appearance" {
            let selectedAppearance = AppearanceSetting(userDisplayName: dataSource[indexPath.row])

            if var infoDict = Bundle.main.infoDictionary {
                infoDict["UIUserInterfaceStyle"] = selectedAppearance.rawValue
                if let infoDictPath = Bundle.main.path(forResource: "Info", ofType: "plist") {
                    (infoDict as NSDictionary).write(toFile: infoDictPath, atomically: true)
                }
            }
            UIApplication.shared.windows.forEach { window in
                if selectedAppearance == .Dark {
                    window.overrideUserInterfaceStyle = .dark
                } else if selectedAppearance == .Light {
                    window.overrideUserInterfaceStyle = .light
                } else {
                    window.overrideUserInterfaceStyle = .unspecified
                }
            }
            select(at: indexPath)
            completionHandler(selectedAppearance.userDisplayName)
        }
    }

    func select(at indexPath: IndexPath) {
        if let lastSelected = selectedRow {
            let cell = selectionTableView.cellForRow(at: IndexPath(row: lastSelected, section: 0))
            cell?.isSelected = false
        }
        selectedRow = indexPath.row
        let cell = selectionTableView.cellForRow(at: indexPath) as? TMSettingSelectionCell
        cell?.isSelected = true
    }

    func changeToLanguage(languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(1)
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMSettingSelectionCell()
        cell.setupEvent(title: dataSource[indexPath.row])
        cell.selectionStyle = .none
        if title == "Appearance" {
            if dataSource[indexPath.row] == AppearanceSetting(rawValue: Bundle.main.object(forInfoDictionaryKey: "UIUserInterfaceStyle") as? String ?? "UnSpecified")?.userDisplayName {
                cell.isSelected = true
                selectedRow = indexPath.row
            }
        } else if title == "Language" {
            if dataSource[indexPath.row] == UserDefaults.standard.stringArray(forKey: "AppleLanguages")?[0] ?? "Chinese" {
                cell.isSelected = true
                selectedRow = indexPath.row
            }
        }
        cell.addObserver(cell, forKeyPath: "isBeenSelected", options: [.new, .old], context: nil)
        return cell
    }
}
