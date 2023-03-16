//
//  EventViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Alamofire
import Foundation
import MapKit
import SwiftyJSON
import TMComponent
import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    lazy var clubListView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    lazy var clubContentView: TMView = {
        let view = TMView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "BackgroundGray")

        view.addSubview(clubListView)
        view.insertSubview(clubContentView, belowSubview: clubListView)

        clubContentView.backgroundColor = UIColor(named: "ComponentBackground")
        clubListView.backgroundColor = UIColor(named: "BackgroundGray")
        clubListView.delegate = self
        clubListView.dataSource = self
        clubListView.separatorStyle = .none
        clubListView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            clubListView.sectionHeaderTopPadding = 0
        }
        clubListView.register(TMClubTableViewCell.self, forCellReuseIdentifier: "TMClubTableViewCell")

        clubContentView.frame = CGRect(x: 38, y: 44, width: UIStandard.shared.screenWidth * 0.3, height: UIStandard.shared.screenHeight * 0.8)
        clubContentView.setup(clubContentView.bounds, clubContentView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth * 0.6, height: UIStandard.shared.screenHeight * 0.8), CGPoint(x: UIStandard.shared.screenWidth * 0.6 + 62, y: 44 + UIStandard.shared.screenHeight * 0.4), 0.3)

        clubListView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(38)
            make.top.equalToSuperview().offset(44)
            make.width.equalTo(UIStandard.shared.screenWidth * 0.3)
            make.height.equalTo(UIStandard.shared.screenHeight * 0.8)
        }
    }

    func showContent() {
        clubContentView.scaleTo(clubContentView.toggle)
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        clubs.count
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let label = UILabel()
        label.text = "My Club"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        132
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        0
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        showContent()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMClubTableViewCell()
        cell.setupUI()
        cell.selectionStyle = .none
        cell.setupEvent(clubIcon: clubs[indexPath.row].icon, clubName: clubs[indexPath.row].name)
        return cell
    }
}
