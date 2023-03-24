//
//  TMClubContentView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import TMComponent
import UIKit

class TMClubContentView: TMView, UITableViewDelegate, UITableViewDataSource {
    var events: [Event] = []

    lazy var clubIconView: TMImageView = {
        let imageView = TMImageView()
        return imageView
    }()

    lazy var clubNameView: TMLabel = {
        let label = TMLabel()
        return label
    }()

    lazy var joinBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    lazy var introView: TMLabel = {
        let view = TMLabel()
        return view
    }()

    lazy var addressView: TMLabel = {
        let view = TMLabel()
        return view
    }()

    lazy var tourView: UITableView = {
        let view = UITableView()
        return view
    }()

    func setupUI() {
        setCorner(radii: 15)
        addSubview(clubIconView)
        addSubview(clubNameView)
        addSubview(introView)
        addSubview(addressView)
        addSubview(tourView)

        clubIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.height.equalTo(68)
            make.width.equalTo(68)
        }
        clubNameView.snp.makeConstraints { make in
            make.top.equalTo(clubIconView.snp.top)
            make.left.equalTo(clubIconView.snp.right).offset(8)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }

        introView.frame = CGRect(x: 88, y: 46, width: 200, height: 38)
        addressView.snp.makeConstraints { make in
            make.top.equalTo(introView.snp.bottom).offset(4)
            make.left.equalTo(clubNameView.snp.left)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        tourView.snp.makeConstraints { make in
            make.top.equalTo(addressView.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(clubIconView.snp.left)
            make.right.equalToSuperview().offset(-12)
        }

        clubIconView.setupUI()

        introView.numberOfLines = 20
        introView.setup(introView.bounds, introView.layer.position, CGRect(x: 0, y: 0, width: 300, height: 118), CGPoint(x: introView.layer.position.x + 50, y: introView.layer.position.y + 40), 0.3)
        introView.addTapGesture(self, #selector(showAllIntro))

        tourView.setCorner(radii: 15)
        tourView.dataSource = self
        tourView.delegate = self
        tourView.separatorStyle = .none
        tourView.register(TMTourView.self, forCellReuseIdentifier: "TMTourView")
        tourView.showsVerticalScrollIndicator = false
        tourView.showsHorizontalScrollIndicator = false
    }

    func setupEvent(club: Club) {
        events = club.events
        let iconConfig = TMImageViewConfig(image: club.icon, contentMode: .scaleAspectFill)
        let nameConfig = TMLabelConfig(title: club.name, font: 20)
        let introConfig = TMLabelConfig(title: club.intro, font: 15)
        let addressConfig = TMLabelConfig(title: club.address, font: 17)
        clubIconView.setupEvent(config: iconConfig)
        clubNameView.setupEvent(config: nameConfig)
        introView.setupEvent(config: introConfig)
        addressView.setupEvent(config: addressConfig)
        tourView.reloadData()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        events.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        242
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMTourView()
        cell.selectionStyle = .none
        cell.setCorner(radii: 15)
        cell.backgroundColor = UIColor(named: "BackgroundGray")
        cell.setupEvent(events[indexPath.row])
        return cell
    }

    @objc func showAllIntro() {
        introView.scaleTo(introView.toggle)
    }
}
