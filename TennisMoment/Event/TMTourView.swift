//
//  TMTourView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/15.
//

import Foundation
import TMComponent

class TMTourView: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    var event = Event(id: 0, icon: "NickKyrgios", name: "", startDate: Date().timeIntervalSince1970, endDate: Date().timeIntervalSince1970, level: .series15, draw: [], schedule: [])
    var currentSeletedIndex = 0

    lazy var tourNameView: TMLabel = {
        let label = TMLabel()
        return label
    }()

    lazy var DateLabel: TMLabel = {
        let label = TMLabel()
        return label
    }()

    lazy var joinBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

//    lazy var drawView: UIView = {
//        let view = UIView()
//        return view
//    }()

    lazy var scheduleView: TMPopUpView = {
        let view = TMPopUpView()
        return view
    }()

    lazy var liveGameView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(tourNameView)
        contentView.addSubview(DateLabel)
        contentView.addSubview(joinBtn)
//        addSubview(drawView)
        contentView.addSubview(scheduleView)
        contentView.addSubview(liveGameView)
        layoutSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scheduleView.frame = CGRect(x: bounds.width - 246, y: 22, width: 148, height: 38)
        bringSubviewToFront(scheduleView)
        scheduleView.delegate = scheduleView
        liveGameView.delegate = self
        liveGameView.dataSource = self
        liveGameView.register(TMEventGameCell.self, forCellReuseIdentifier: "TMEventGameCell")
        liveGameView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        liveGameView.showsVerticalScrollIndicator = false
        liveGameView.showsHorizontalScrollIndicator = false
        liveGameView.separatorStyle = .none

        tourNameView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
        }
        DateLabel.snp.makeConstraints { make in
            make.top.equalTo(tourNameView.snp.bottom).offset(6)
            make.left.equalTo(tourNameView.snp.left)
        }
        joinBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(tourNameView.snp.bottom).offset(3)
            make.width.equalTo(68)
            make.height.equalTo(44)
        }
//        drawView.snp.makeConstraints { make in
//            make.
//        }

        liveGameView.frame = CGRect(x: 12, y: 68, width: 668.5, height: 168)

        joinBtn.setupUI()
        scheduleView.setupUI()
    }

    func setupEvent(_ event: Event) {
        self.event = event
        let nameConfig = TMLabelConfig(title: event.name, font: 19)
        let dateConfig = TMLabelConfig(title: "\(event.startDate.convertToString(formatterString: "MM-dd HH:mm:ss")) -- \(event.endDate.convertToString(formatterString: "MM-dd HH:mm:ss"))", font: 13)
        var joinConfig = TMButtonConfig(title: "JOIN NOW", action: #selector(joinEvent), actionTarget: self)
        if Date().timeIntervalSince1970 > event.startDate, Date().timeIntervalSince1970 < event.endDate {
            joinConfig = TMButtonConfig(title: "ONGOING", action: nil, actionTarget: self)
        } else if Date().timeIntervalSince1970 > event.endDate {
            joinConfig = TMButtonConfig(title: "DONE", action: nil, actionTarget: self)
        } else if Date().timeIntervalSince1970 < event.startDate {
            if TMUser.user.allEvents.contains(where: { $0.id == event.id }) {
                joinConfig = TMButtonConfig(title: "ONGOING", action: nil, actionTarget: self)
            }
        }
        var scheduleCells: [TMPopUpViewCell] = []
        for date in TMDataConvert.datesInRangeString(startDate: event.startDate, endDate: event.endDate) {
            let cell = TMPopUpViewCell()
            cell.setupUI()
            cell.setupEvent(title: "\(date) schedule")
            scheduleCells.append(cell)
        }
        let scheduleViewConfig = TMPopUpViewConfig(cells: scheduleCells, rowHeight: 38)

        tourNameView.setupEvent(config: nameConfig)
        DateLabel.setupEvent(config: dateConfig)
        joinBtn.setupEvent(config: joinConfig)
        scheduleView.setupEvent(config: scheduleViewConfig)
        liveGameView.reloadData()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        event.schedule[currentSeletedIndex].count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        330
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMEventGameCell()
        let rotationAngle = CGFloat.pi / 2 // 旋转角度为90度
        let transform = CGAffineTransform(rotationAngle: rotationAngle)
        cell.transform = transform
        cell.backgroundColor = UIColor(named: "BackgroundGray")
        cell.selectionStyle = .none
        cell.setupEvent(game: event.schedule[currentSeletedIndex][indexPath.row])
        return cell
    }

    @objc func joinEvent() {
        print("SB")
    }
}
