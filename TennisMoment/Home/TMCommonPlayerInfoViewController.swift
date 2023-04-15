//
//  TMCommonPlayerInfoViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/11.
//

import Foundation
import TMComponent
import UIKit

class TMCommonPlayerInfoViewController: UIViewController, UITableViewDelegate {
    let infoTableViewDelegate = InfoTableViewDelegate()
    let commonStatsTableViewDelegate = CommonStatsTableViewDelegate()
    let serveStatsDataSource = ServeStatsTableViewDataSource()
    let commonStatsDataSource = CommonStatsTableViewDataSource()
    let infoDataSource = InfoTableViewDataSource()

    var player: Player = Player()
    var games: [Game] = []

    lazy var player1IconView: TMIconView = {
        let iconView = TMIconView()
        return iconView
    }()

    lazy var player1RankingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var infoTableView: UITableView = {
        let view = UITableView()
        return view
    }()

    lazy var resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var resultBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var serveStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var serveStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var serveStatsView: UITableView = {
        let view = UITableView()
        return view
    }()

    lazy var commonStatsBackgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var commonStatsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var commonStatsView: UITableView = {
        let view = UITableView()
        return view
    }()

    lazy var addFriendBtn: TMButton = {
        let btn = TMButton()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundGray")
        view.addSubview(player1IconView)
        view.addSubview(player1RankingLabel)
        view.addSubview(resultBackgroundView)
        view.addSubview(addFriendBtn)
        resultBackgroundView.addSubview(infoTableView)
        resultBackgroundView.addSubview(resultLabel)
        view.addSubview(commonStatsBackgroundView)
        commonStatsBackgroundView.addSubview(commonStatsLabel)
        commonStatsBackgroundView.addSubview(commonStatsView)
        view.addSubview(serveStatsBackgroundView)
        serveStatsBackgroundView.addSubview(serveStatsLabel)
        serveStatsBackgroundView.addSubview(serveStatsView)

        player1IconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(138)
            make.height.equalTo(188)
        }
        player1RankingLabel.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.bottom).offset(6)
            make.left.equalTo(player1IconView.snp.left)
            make.width.equalTo(player1IconView.snp.width)
            make.height.equalTo(22)
        }
        addFriendBtn.snp.makeConstraints { make in
            make.top.equalTo(player1RankingLabel.snp.bottom).offset(12)
            make.left.equalTo(player1IconView.snp.left)
            make.right.equalTo(player1IconView.snp.right)
            make.height.equalTo(50)
        }
        resultBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top).offset(12)
            make.width.equalTo(258)
            make.left.equalTo(player1IconView.snp.right).offset(12)
            make.height.equalTo(268)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(88)
            make.height.equalTo(25)
        }
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        commonStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(resultBackgroundView.snp.bottom).offset(12)
            make.right.equalTo(infoTableView.snp.right)
            make.left.equalTo(infoTableView.snp.left)
            make.bottom.equalToSuperview()
        }
        commonStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(112)
            make.height.equalTo(25)
        }
        commonStatsView.snp.makeConstraints { make in
            make.top.equalTo(commonStatsLabel.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        serveStatsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(player1IconView.snp.top).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.left.equalTo(resultBackgroundView.snp.right).offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        serveStatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(288)
            make.height.equalTo(25)
        }
        serveStatsView.snp.makeConstraints { make in
            make.top.equalTo(serveStatsLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        resultBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        commonStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        serveStatsBackgroundView.backgroundColor = UIColor(named: "ComponentBackground")
        resultBackgroundView.setCorner(radii: 15)
        commonStatsBackgroundView.setCorner(radii: 15)
        serveStatsBackgroundView.setCorner(radii: 15)
        player1IconView.setupUI()
        infoTableView.register(TMCommonPlayerInfoTableViewCell.self, forCellReuseIdentifier: "Info")
        commonStatsView.register(TMCommonPlayerInfoTableViewCell.self, forCellReuseIdentifier: "CommonStats")
        serveStatsView.register(TMCommonPlayerInfoTableViewCell.self, forCellReuseIdentifier: "Stats")
        infoTableView.delegate = infoTableViewDelegate
        commonStatsView.delegate = commonStatsTableViewDelegate
        serveStatsView.delegate = self
        resultLabel.text = NSLocalizedString("Basic Info", comment: "")
        commonStatsLabel.text = NSLocalizedString("Stats", comment: "")
        serveStatsLabel.text = NSLocalizedString("STATS", comment: "")
        resultLabel.font = UIFont.systemFont(ofSize: 23)
        commonStatsLabel.font = UIFont.systemFont(ofSize: 23)
        serveStatsLabel.font = UIFont.systemFont(ofSize: 23)
        player1RankingLabel.textAlignment = .center
        serveStatsLabel.textAlignment = .center

        if TMUser.user.friends.contains(where:
            { $0.id == player.id }) {
            let addFriendBtnConfig = TMButtonConfig(title: "you are friend", actionTarget: self)
            addFriendBtn.setUp(with: addFriendBtnConfig)
        } else {
            let addFriendBtnConfig = TMButtonConfig(title: "Add Friend", action: #selector(addFriend), actionTarget: self)
            addFriendBtn.setUp(with: addFriendBtnConfig)
        }

        setupEvent(player: player)
    }

    func setupEvent(player: Player) {
        let player1IconConfig = TMIconViewConfig(icon: player.icon.toPng(), name: player.name)

        let firstServeIn = TMDataConvert.Divide(player.careerStats.firstServePointsIn, by: player.careerStats.firstServePoints)
        let firstServeWon = TMDataConvert.Divide(player.careerStats.firstServePointsWon, by: player.careerStats.firstServePointsIn)
        let secondServeIn = TMDataConvert.Divide(player.careerStats.secondServePointsIn, by: player.careerStats.servePoints - player.careerStats.firstServePoints)
        let secondServeWon = TMDataConvert.Divide(player.careerStats.secondServePointsWon, by: player.careerStats.secondServePointsIn)
        let firstReturnServeIn = TMDataConvert.Divide(player.careerStats.firstServeReturnPointsIn, by: player.careerStats.firstServeReturnPoints)
        let firstReturnServeWon = TMDataConvert.Divide(player.careerStats.firstServeReturnPointsWon, by: player.careerStats.firstServeReturnPointsIn)
        let secondReturnServeIn = TMDataConvert.Divide(player.careerStats.secondServeReturnPointsIn, by: player.careerStats.returnServePoints - player.careerStats.firstServeReturnPoints)
        let secondReturnServeWon = TMDataConvert.Divide(player.careerStats.secondServeReturnPointsWon, by: player.careerStats.secondServeReturnPointsIn)
        let breakPointSaved = TMDataConvert.Divide(player.careerStats.breakPointsSaved, by: player.careerStats.breakPointsFaced)
        let breakPointConvert = TMDataConvert.Divide(player.careerStats.breakPointsConverted, by: player.careerStats.breakPointsOpportunities)
        let serveGameWon = TMDataConvert.Divide(player.careerStats.serveGamesWon, by: player.careerStats.serveGamesPlayed)
        let returnGameWon = TMDataConvert.Divide(player.careerStats.returnGamesWon, by: player.careerStats.returnGamesPlayed)
        let servePointWon = TMDataConvert.Divide(player.careerStats.firstServePointsWon + player.careerStats.secondServePointsWon, by: player.careerStats.firstServePointsIn + player.careerStats.secondServePointsIn)
        let returnPointWon = TMDataConvert.Divide(player.careerStats.firstServeReturnPointsWon + player.careerStats.secondServeReturnPointsWon, by: player.careerStats.firstServeReturnPointsIn + player.careerStats.secondServeReturnPointsIn)

        let firstServeInConfig = [NSLocalizedString("1ST Serve In", comment: ""), "\(firstServeIn.TwoBitsRem())%"]
        let firstServeWonConfig = [NSLocalizedString("1ST Serve Won", comment: ""), "\(firstServeWon.TwoBitsRem())%"]
        let secondServeInConfig = [NSLocalizedString("2ND Serve In", comment: ""), "\(secondServeIn.TwoBitsRem())%"]
        let secondServeWonConfig = [NSLocalizedString("2ND Serve Won", comment: ""), "\(secondServeWon.TwoBitsRem())%"]
        let breakPointSavedConfig = [NSLocalizedString("Break Point Saved", comment: ""), "\(breakPointSaved.TwoBitsRem())%"]
        let servePointWonConfig = [NSLocalizedString("Serve Point Won", comment: ""), "\(servePointWon.TwoBitsRem())%"]
        let serveGameWonConfig = [NSLocalizedString("Serve Game Won", comment: ""), "\(serveGameWon.TwoBitsRem())%"]

        let firstReturnServeInConfig = [NSLocalizedString("1ST Return In", comment: ""), "\(firstReturnServeIn.TwoBitsRem())%"]
        let firstReturnServeWonConfig = [NSLocalizedString("1ST Return Won", comment: ""), "\(firstReturnServeWon.TwoBitsRem())%"]
        let secondReturnServeInConfig = [NSLocalizedString("2ND Return In", comment: ""), "\(secondReturnServeIn.TwoBitsRem())%"]
        let secondReturnServeWonConfig = [NSLocalizedString("2ND Return Won", comment: ""), "\(secondReturnServeWon.TwoBitsRem())%"]
        let breakPointConvertConfig = [NSLocalizedString("Break Point Convert", comment: ""), "\(breakPointConvert.TwoBitsRem())%"]
        let returnPointWonConfig = [NSLocalizedString("Return Point Won", comment: ""), "\(returnPointWon.TwoBitsRem())%"]
        let returnGameWonConfig = [NSLocalizedString("Return Game Won", comment: ""), "\(returnGameWon.TwoBitsRem())%"]

        let acesConfig = [NSLocalizedString("Aces", comment: ""), "\(player.careerStats.aces)"]
        let doubleFaultsConfig = [NSLocalizedString("Double Faults", comment: ""), "\(player.careerStats.doubleFaults)"]
        let returnAcesConfig = [NSLocalizedString("Return Aces", comment: ""), "\(player.careerStats.returnAces)"]
        let netPointsConfig = [NSLocalizedString("Net Points", comment: ""), "\(player.careerStats.netPoints)"]
        let unforcedErrorsConfig = [NSLocalizedString("UEs", comment: ""), "\(player.careerStats.unforcedErrors)"]
        let forehandWinnersConfig = [NSLocalizedString("FH Winners", comment: ""), "\(player.careerStats.forehandWinners)"]
        let backhandWinnersConfig = [NSLocalizedString("BH Winners", comment: ""), "\(player.careerStats.backhandWinners)"]

        let ageConfig = [NSLocalizedString("Age", comment: ""), "\(player.age)"]
        let widthConfig = [NSLocalizedString("Width", comment: ""), "\(player.width)"]
        let yearPlayedConfig = [NSLocalizedString("YearsPlayed", comment: ""), "\(player.yearsPlayed)"]
        let heightConfig = [NSLocalizedString("Height", comment: ""), "\(player.height)"]
        let gripConfig = [NSLocalizedString("Grip", comment: ""), "\(player.grip.rawValue)"]
        let backhandConfig = [NSLocalizedString("Backhand", comment: ""), "\(player.backhand.rawValue)"]
        let pointsConfig = [NSLocalizedString("Current Points", comment: ""), "\(player.points)"]

        infoDataSource.configs = [ageConfig, yearPlayedConfig, heightConfig, widthConfig, gripConfig, backhandConfig, pointsConfig]

        commonStatsDataSource.configs = [acesConfig, doubleFaultsConfig, returnAcesConfig, netPointsConfig, unforcedErrorsConfig, forehandWinnersConfig, backhandWinnersConfig]

        serveStatsDataSource.configs = [firstServeInConfig, firstServeWonConfig, secondServeInConfig, secondServeWonConfig, breakPointSavedConfig, servePointWonConfig, serveGameWonConfig, firstReturnServeInConfig, firstReturnServeWonConfig, secondReturnServeInConfig, secondReturnServeWonConfig, breakPointConvertConfig, returnPointWonConfig, returnGameWonConfig]

        player1IconView.setupEvent(config: player1IconConfig)
        infoTableView.dataSource = infoDataSource
        commonStatsView.dataSource = commonStatsDataSource
        serveStatsView.dataSource = serveStatsDataSource
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        48
    }

    @objc func addFriend() {
        guard player.id != TMUser.user.id else {
            let toastView = UILabel()
            toastView.text = "Can not add youself to your friend list"
            toastView.bounds = view.bounds
            toastView.backgroundColor = UIColor(named: "ComponentBackground")
            toastView.textAlignment = .center
            toastView.setCorner(radii: 15)
            view.showToast(toastView, position: .center) { _ in
            }
            return
        }
        TMUser.addFriend(player.id) { res in
            if res {
                let toastView = UILabel()
                toastView.text = "\(self.player.name) is already your friend"
                toastView.bounds = self.view.bounds
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                self.view.showToast(toastView, position: .center) { _ in
                }
                let addFriendBtnConfig = TMButtonConfig(title: "you are friend", actionTarget: self)
                self.addFriendBtn.setupEvent(config: addFriendBtnConfig)
            } else {
                let toastView = UILabel()
                toastView.text = "add friend fail"
                toastView.bounds = self.view.bounds
                toastView.backgroundColor = UIColor(named: "ComponentBackground")
                toastView.textAlignment = .center
                toastView.setCorner(radii: 15)
                self.view.showToast(toastView, position: .center) { _ in
                }
            }
        }
    }
}

class InfoTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        30
    }
}

class CommonStatsTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        40
    }
}

class ServeStatsTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}

class ReturnStatsTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}

class CommonStatsTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}

class InfoTableViewDataSource: NSObject, UITableViewDataSource {
    var configs: [[String]] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        configs.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMCommonPlayerInfoTableViewCell()
        cell.setupEvent(title: configs[indexPath.row][0], info: configs[indexPath.row][1])
        return cell
    }
}
