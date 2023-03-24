//
//  TMrecordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import SwiftyJSON
import TMComponent
import UIKit

class TMRecordView: TMUserInteractionUnabledView {
    var game = Game(json: JSON())

    var isServingOnLeft: Bool = true

    var player1Stats = Stats(json: JSON())
    var player2Stats = Stats(json: JSON())
    var livePoint: [Int] = [0, 0]

    lazy var titleView: UILabel = {
        let view = UILabel()
        return view
    }()

    /// 左侧球员信息
    lazy var leftBasicInfoView: TMIconView = {
        var view = TMIconView()
        view.isUserInteractionEnabled = false
        return view
    }()

    /// 右侧球员信息
    lazy var rightBasicInfoView: TMIconView = {
        var view = TMIconView()
        view.isUserInteractionEnabled = false
        return view
    }()

    /// 左侧球员记分器
    lazy var leftScoreControllerView: TMScoreControllerView = {
        var button = TMScoreControllerView()
        return button
    }()

    /// 右侧球员记分器
    lazy var rightScoreControllerView: TMScoreControllerView = {
        var button = TMScoreControllerView()
        return button
    }()

    /// 记分板
    lazy var recordPointView: TMPointRecordView = {
        let view = TMPointRecordView()
        view.isUserInteractionEnabled = false
        return view
    }()

    // 无比赛时提示窗口
    lazy var alartView: UILabel = {
        let view = UILabel()
        return view
    }()

    func setupUI() {
        setCorner(radii: 15)

        titleView.isHidden = false
        leftBasicInfoView.isHidden = false
        rightBasicInfoView.isHidden = false
        leftScoreControllerView.isHidden = false
        rightScoreControllerView.isHidden = false
        recordPointView.isHidden = false
        alartView.isHidden = true

        addSubview(titleView)
        addSubview(leftBasicInfoView)
        addSubview(rightBasicInfoView)
        addSubview(recordPointView)
        addSubview(leftScoreControllerView)
        addSubview(rightScoreControllerView)

        let player1AceBtnConfig = TMButtonConfig(title: "ACE", action: #selector(player1AceBtnTap), actionTarget: self)
        let player1ServeScoreBtnConfig = TMButtonConfig(title: "SERVE WINNER", action: #selector(player1ServeScoreBtnTap), actionTarget: self)
        let player1ServeFaultBtnConfig = TMButtonConfig(title: "SERVE  FAULT", action: #selector(player1ServeFaultBtnTap), actionTarget: self)
        let player1ReturnAceBtnConfig = TMButtonConfig(title: "RETURN  ACE", action: #selector(player1ReturnAceBtnTap), actionTarget: self)
        let player1UnforcedErrorBtnConfig = TMButtonConfig(title: "UNFORCE ERROR", action: #selector(player1UnforceErrorBtnTap), actionTarget: self)
        let player1ForehandWinnersBtnConfig = TMButtonConfig(title: "FOREHAND WINNER", action: #selector(player1ForehandWinnersBtnTap), actionTarget: self)
        let player1BackhandWinnersBtnConfig = TMButtonConfig(title: "BACKHAND WINNER", action: #selector(player1BackhandWinnersBtnTap), actionTarget: self)
        let player1NetPointBtnConfig = TMButtonConfig(title: "NET POINT", action: #selector(player1NetPointBtnTap), actionTarget: self)

        let player2AceBtnConfig = TMButtonConfig(title: "ACE", action: #selector(player2AceBtnTap), actionTarget: self)
        let player2ServeScoreBtnConfig = TMButtonConfig(title: "SERVE WINNER", action: #selector(player2ServeScoreBtnTap), actionTarget: self)
        let player2ServeFaultBtnConfig = TMButtonConfig(title: "SERVE  FAULT", action: #selector(player2ServeFaultBtnTap), actionTarget: self)
        let player2ReturnAceBtnConfig = TMButtonConfig(title: "RETURN  ACE", action: #selector(player2ReturnAceBtnTap), actionTarget: self)
        let player2UnforcedErrorBtnConfig = TMButtonConfig(title: "UNFORCE ERROR", action: #selector(player2UnforceErrorBtnTap), actionTarget: self)
        let player2ForehandWinnersBtnConfig = TMButtonConfig(title: "FOREHAND WINNER", action: #selector(player2ForehandWinnersBtnTap), actionTarget: self)
        let player2BackhandWinnersBtnConfig = TMButtonConfig(title: "BACKHAND WINNER", action: #selector(player2BackhandWinnersBtnTap), actionTarget: self)
        let player2NetPointBtnConfig = TMButtonConfig(title: "NET POINT", action: #selector(player2NetPointBtnTap), actionTarget: self)

        leftScoreControllerView.aceBtn.setUp(with: player1AceBtnConfig)
        leftScoreControllerView.serveScoreBtn.setUp(with: player1ServeScoreBtnConfig)
        leftScoreControllerView.serveFaultBtn.setUp(with: player1ServeFaultBtnConfig)
        leftScoreControllerView.returnAceBtn.setUp(with: player1ReturnAceBtnConfig)
        leftScoreControllerView.unforcedErrorBtn.setUp(with: player1UnforcedErrorBtnConfig)
        leftScoreControllerView.forehandWinnersBtn.setUp(with: player1ForehandWinnersBtnConfig)
        leftScoreControllerView.backhandWinnersBtn.setUp(with: player1BackhandWinnersBtnConfig)
        leftScoreControllerView.netPointBtn.setUp(with: player1NetPointBtnConfig)

        rightScoreControllerView.aceBtn.setUp(with: player2AceBtnConfig)
        rightScoreControllerView.serveScoreBtn.setUp(with: player2ServeScoreBtnConfig)
        rightScoreControllerView.serveFaultBtn.setUp(with: player2ServeFaultBtnConfig)
        rightScoreControllerView.returnAceBtn.setUp(with: player2ReturnAceBtnConfig)
        rightScoreControllerView.unforcedErrorBtn.setUp(with: player2UnforcedErrorBtnConfig)
        rightScoreControllerView.forehandWinnersBtn.setUp(with: player2ForehandWinnersBtnConfig)
        rightScoreControllerView.backhandWinnersBtn.setUp(with: player2BackhandWinnersBtnConfig)
        rightScoreControllerView.netPointBtn.setUp(with: player2NetPointBtnConfig)

        titleView.text = "In Progress"
        titleView.textColor = UIColor(named: "ContentBackground")
        titleView.font = UIFont.systemFont(ofSize: 23)

        titleView.frame = CGRect(x: 24, y: 22, width: UIStandard.shared.screenWidth * 0.1, height: 30)
        leftBasicInfoView.frame = CGRect(x: 12, y: 64, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        rightBasicInfoView.frame = CGRect(x: bounds.width - leftBasicInfoView.bounds.width - 12, y: 64, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        recordPointView.frame = CGRect(x: (bounds.width / 2) - UIStandard.shared.screenWidth * 0.06, y: 64 + ((UIStandard.shared.screenHeight * 0.24 - 190) / 2), width: UIStandard.shared.screenWidth * 0.12, height: 190)

        leftBasicInfoView.setupUI()
        rightBasicInfoView.setupUI()
        recordPointView.setupUI()

        let pointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 50, rowSpacing: 20, font: UIFont.systemFont(ofSize: 17), isTitleHidden: true, isPlayer1Serving: true, isPlayer1Left: true, player1SetNum: 0, player2SetNum: 0, player1GameNum: 0, player2GameNum: 0, player1PointNum: "0", player2PointNum: "0")
        recordPointView.setup(with: pointRecordViewConfig)
    }

    func setupAlart() {
        titleView.isHidden = true
        leftBasicInfoView.isHidden = true
        rightBasicInfoView.isHidden = true
        leftScoreControllerView.isHidden = true
        rightScoreControllerView.isHidden = true
        recordPointView.isHidden = true
        alartView.isHidden = false

        addSubview(alartView)
        alartView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
        }
        let lastGameTime = UserDefaults.standard.double(forKey: "LastGameTime")
        let gap = Date().timeIntervalSince1970 - lastGameTime
        let days = Int(gap / (24 * 3600))
        let hours = Int((gap / 3600).truncatingRemainder(dividingBy: 24))
        alartView.text = "\(days) days \(hours) hours since last match"
        alartView.font = UIFont.systemFont(ofSize: 22)
        alartView.textAlignment = .center
    }

    func setNewGame(game: Game) {
        leftBasicInfoView.isHidden = false
        rightBasicInfoView.isHidden = false
        leftScoreControllerView.isHidden = false
        rightScoreControllerView.isHidden = false
        recordPointView.isHidden = false
        alartView.isHidden = true
        setupEvent(game: game)
    }

    func setupEvent(game: Game) {
        self.game = game
        isServingOnLeft = game.isPlayer1Left == game.isPlayer1Serving

        // 说明player1在左侧⬅️
        if game.isPlayer1Left {
            leftBasicInfoView.updateInfo(with: game.player1.icon, named: game.player1.name)
            rightBasicInfoView.updateInfo(with: game.player2.icon, named: game.player2.name)
        } else {
            leftBasicInfoView.updateInfo(with: game.player2.icon, named: game.player2.name)
            rightBasicInfoView.updateInfo(with: game.player1.icon, named: game.player1.name)
        }
        recordPointView.updateData(liveScore: game.result, isPlayer1Serving: game.isPlayer1Serving, isPlayer1Left: game.isPlayer1Left, setConfigNum: game.setNum, gameConfigNum: game.gameNum)
        let lastGame = self.game.result[game.result.count - 1].last ?? [0, 0]
        if lastGame[0] == 5 || lastGame[1] == 5 {
            livePoint = [0, 0]
        } else {
            livePoint = lastGame
        }

        player1Stats = game.player1Stats
        player2Stats = game.player2Stats
    }

    func refreshData() {
        recordPointView.updateData(liveScore: game.result, isPlayer1Serving: game.isPlayer1Serving, isPlayer1Left: game.isPlayer1Left, setConfigNum: game.setNum, gameConfigNum: game.gameNum)
        if game.result != [[]] {
            let lastGame = game.result[game.result.count - 1].removeLast()
            if lastGame[0] == 5 || lastGame[1] == 5 {
                livePoint = [0, 0]
                game.result[game.result.count - 1].append(lastGame)
            } else {
                livePoint = lastGame
            }
        }
    }

    override func scaleTo(_ isEnlarge: Bool, completionHandler: @escaping () -> Void) {
        super.scaleTo(isEnlarge, completionHandler: completionHandler)
        if isEnlarge {
            titleView.isHidden = false
            leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
            rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
            recordPointView.scaleTo(recordPointView.toggle)

            recordPointView.scaleTo(newRowHeight: 50, newRowSpacing: 20, newFont: UIFont.systemFont(ofSize: 17), isTitleHidden: true)

            leftScoreControllerView.isHidden = true
            rightScoreControllerView.isHidden = true
        } else {
            titleView.isHidden = true
            leftBasicInfoView.setup(leftBasicInfoView.bounds, leftBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: 24 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
            rightBasicInfoView.setup(rightBasicInfoView.bounds, rightBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: UIStandard.shared.screenWidth - 24 - UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
            recordPointView.setup(recordPointView.bounds, recordPointView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.4, height: UIStandard.shared.screenWidth * 0.25), CGPoint(x: UIStandard.shared.screenWidth * 0.5, y: 104 + UIStandard.shared.screenHeight * 0.15), 0.3)

            leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
            rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
            recordPointView.scaleTo(recordPointView.toggle)

            recordPointView.scaleTo(newRowHeight: 70, newRowSpacing: 40, newFont: UIFont.systemFont(ofSize: 24), isTitleHidden: false)

            leftScoreControllerView.setupUI(isLeft: true)
            rightScoreControllerView.setupUI(isLeft: false)

            leftScoreControllerView.frame = CGRect(x: 40, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)
            rightScoreControllerView.frame = CGRect(x: UIStandard.shared.screenWidth - 40 - UIStandard.shared.screenHeight * 0.46, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)

            leftScoreControllerView.isHidden = false
            rightScoreControllerView.isHidden = false
        }
    }

    @objc func player1AceBtnTap() {
        recordStats(type: .ace, isLeft: true)
        if game.isPlayer1Left == game.isPlayer1Serving {
            scorePoint(isLeft: true)
        }
    }

    @objc func player1ServeScoreBtnTap() {
        recordStats(type: .serveWinner, isLeft: true)
        if game.isPlayer1Left == game.isPlayer1Serving {
            scorePoint(isLeft: true)
        }
    }

    @objc func player1ServeFaultBtnTap() {
        recordStats(type: .serveFault, isLeft: true)
        if game.isPlayer1Serving {
            if game.isPlayer1Left {
                if game.isPlayer1FirstServe {
                    scorePoint(isLeft: false)
                }
            }
        } else {
            if !game.isPlayer1Left {
                if game.isPlayer2FirstServe {
                    scorePoint(isLeft: false)
                }
            }
        }
    }

    @objc func player1ReturnAceBtnTap() {
        recordStats(type: .returnAce, isLeft: true)
        if game.isPlayer1Left != game.isPlayer1Serving {
            scorePoint(isLeft: true)
        }
    }

    @objc func player1UnforceErrorBtnTap() {
        recordStats(type: .unforcedError, isLeft: true)
        scorePoint(isLeft: false)
    }

    @objc func player1ForehandWinnersBtnTap() {
        recordStats(type: .forehandWinner, isLeft: true)
        scorePoint(isLeft: true)
    }

    @objc func player1BackhandWinnersBtnTap() {
        recordStats(type: .backhandWinner, isLeft: true)
        scorePoint(isLeft: true)
    }

    @objc func player1NetPointBtnTap() {
        recordStats(type: .netPoint, isLeft: true)
        scorePoint(isLeft: true)
    }

    @objc func player2AceBtnTap() {
        recordStats(type: .ace, isLeft: false)
        if game.isPlayer1Left != game.isPlayer1Serving {
            scorePoint(isLeft: false)
        }
    }

    @objc func player2ServeScoreBtnTap() {
        recordStats(type: .serveWinner, isLeft: false)
        if game.isPlayer1Left != game.isPlayer1Serving {
            scorePoint(isLeft: false)
        }
    }

    @objc func player2ServeFaultBtnTap() {
        recordStats(type: .serveFault, isLeft: false)
        if game.isPlayer1Serving {
            if !game.isPlayer1Left {
                if game.isPlayer1FirstServe {
                    scorePoint(isLeft: true)
                }
            }
        } else {
            if game.isPlayer1Left {
                if game.isPlayer2FirstServe {
                    scorePoint(isLeft: true)
                }
            }
        }
    }

    @objc func player2ReturnAceBtnTap() {
        recordStats(type: .returnAce, isLeft: false)
        if game.isPlayer1Left == game.isPlayer1Serving {
            scorePoint(isLeft: false)
        }
    }

    @objc func player2UnforceErrorBtnTap() {
        recordStats(type: .unforcedError, isLeft: false)
        scorePoint(isLeft: true)
    }

    @objc func player2ForehandWinnersBtnTap() {
        recordStats(type: .forehandWinner, isLeft: false)
        scorePoint(isLeft: false)
    }

    @objc func player2BackhandWinnersBtnTap() {
        recordStats(type: .backhandWinner, isLeft: false)
        scorePoint(isLeft: false)
    }

    @objc func player2NetPointBtnTap() {
        recordStats(type: .netPoint, isLeft: false)
        scorePoint(isLeft: false)
    }

    func scorePoint(isLeft: Bool) {
        if recordPointView.config.player1GameNum == game.gameNum, recordPointView.config.player2GameNum == game.gameNum {
            scoreTieBreakPoint(isLeft: isLeft)
        } else {
            if isLeft {
                switch recordPointView.config.player1PointNum {
                case "0":
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "15")
                    recordPointView.config.player1PointNum = "15"
                    scoreUp(isLeft: isLeft)
                case "15":
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "30")
                    recordPointView.config.player1PointNum = "30"
                    scoreUp(isLeft: isLeft)
                case "30":
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "40")
                    recordPointView.config.player1PointNum = "40"
                    scoreUp(isLeft: isLeft)
                case "40":
                    if recordPointView.config.player2PointNum == "40" {
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "AD")
                        recordPointView.config.player1PointNum = "AD"
                        scoreUp(isLeft: isLeft)
                    } else if recordPointView.config.player2PointNum == "AD" {
                        recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "40")
                        recordPointView.config.player2PointNum = "40"
                        scoreDowm(isLeft: !isLeft)
                    } else {
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "0")
                        recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "0")
                        recordPointView.config.player1PointNum = "0"
                        recordPointView.config.player2PointNum = "0"
                        scoreUp(isLeft: isLeft)
                        scoreUp(isLeft: isLeft)
                        scoreGame(isLeft: isLeft)
                    }
                case "AD":
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "0")
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "0")
                    recordPointView.config.player1PointNum = "0"
                    recordPointView.config.player2PointNum = "0"
                    scoreUp(isLeft: isLeft)
                    scoreGame(isLeft: isLeft)
                default:
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "0")
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "0")
                }
            } else {
                switch recordPointView.config.player2PointNum {
                case "0":
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "15")
                    recordPointView.config.player2PointNum = "15"
                    scoreUp(isLeft: isLeft)
                case "15":
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "30")
                    recordPointView.config.player2PointNum = "30"
                    scoreUp(isLeft: isLeft)
                case "30":
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "40")
                    recordPointView.config.player2PointNum = "40"
                    scoreUp(isLeft: isLeft)
                case "40":
                    if recordPointView.config.player1PointNum == "40" {
                        recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "AD")
                        recordPointView.config.player2PointNum = "AD"
                        scoreUp(isLeft: isLeft)
                    } else if recordPointView.config.player1PointNum == "AD" {
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "40")
                        recordPointView.config.player1PointNum = "40"
                        scoreDowm(isLeft: !isLeft)
                    } else {
                        recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "0")
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "0")
                        recordPointView.config.player1PointNum = "0"
                        recordPointView.config.player2PointNum = "0"
                        scoreUp(isLeft: isLeft)
                        scoreUp(isLeft: isLeft)
                        scoreGame(isLeft: isLeft)
                    }
                case "AD":
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "0")
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "0")
                    recordPointView.config.player1PointNum = "0"
                    recordPointView.config.player2PointNum = "0"
                    scoreUp(isLeft: isLeft)
                    scoreGame(isLeft: isLeft)
                default:
                    recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: "0")
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: "0")
                }
            }
        }
    }

    func scoreTieBreakPoint(isLeft: Bool) {
        if isLeft {
            let point = Int(recordPointView.config.player1PointNum) ?? 0
            if point < 6 {
                recordPointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "\(point + 1)")
                recordPointView.config.player1PointNum = "\(point + 1)"
                scoreUp(isLeft: isLeft)
                changePositionInTieBreak()
            } else {
                if point - (Int(recordPointView.config.player2PointNum) ?? 0) < 1 {
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "\(point + 1)")
                    recordPointView.config.player1PointNum = "\(point + 1)"
                    scoreUp(isLeft: isLeft)
                    changePositionInTieBreak()
                } else {
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "0")
                    recordPointView.updateRightData(at: 2, isServingOnRight: false, newNum: "0")
                    recordPointView.config.player1PointNum = "0"
                    recordPointView.config.player2PointNum = "0"
                    scoreUp(isLeft: isLeft)
                    scoreGame(isLeft: isLeft)
                }
            }
        } else {
            let point = Int(recordPointView.config.player2PointNum) ?? 0
            if point < 6 {
                recordPointView.updateRightData(at: 2, isServingOnRight: false, newNum: "\(point + 1)")
                recordPointView.config.player2PointNum = "\(point + 1)"
                scoreUp(isLeft: isLeft)
                changePositionInTieBreak()
            } else {
                if point - (Int(recordPointView.config.player1PointNum) ?? 0) < 1 {
                    recordPointView.updateRightData(at: 2, isServingOnRight: false, newNum: "\(point + 1)")
                    recordPointView.config.player2PointNum = "\(point + 1)"
                    scoreUp(isLeft: isLeft)
                    changePositionInTieBreak()
                } else {
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "0")
                    recordPointView.updateRightData(at: 2, isServingOnRight: false, newNum: "0")
                    recordPointView.config.player1PointNum = "0"
                    recordPointView.config.player2PointNum = "0"
                    scoreUp(isLeft: isLeft)
                    scoreGame(isLeft: isLeft)
                }
            }
        }
    }

    func scoreGame(isLeft: Bool) {
        if isLeft {
            if recordPointView.config.player1GameNum < game.gameNum - 1 {
                recordPointView.config.player1GameNum += 1
                dealWithPosition(isGameDone: true)
            } else if recordPointView.config.player1GameNum == game.gameNum - 1, recordPointView.config.player2GameNum == game.gameNum || recordPointView.config.player2GameNum == game.gameNum - 1 {
                recordPointView.config.player1GameNum = game.gameNum
                if recordPointView.config.player2GameNum == game.gameNum {
                    enterTieBreak()
                } else {
                    dealWithPosition(isGameDone: true)
                }
            } else {
                recordPointView.config.player1GameNum = 0
                recordPointView.config.player2GameNum = 0
                scoreSet(isLeft: isLeft)
                dealWithPosition(isGameDone: false)
            }
        } else {
            let gameNum = recordPointView.config.player2GameNum
            if gameNum < game.gameNum - 1 {
                recordPointView.config.player2GameNum += 1
                dealWithPosition(isGameDone: true)
            } else if gameNum == game.gameNum - 1, recordPointView.config.player1GameNum == game.gameNum || recordPointView.config.player1GameNum == game.gameNum - 1 {
                recordPointView.config.player2GameNum = game.gameNum
                if recordPointView.config.player1GameNum == game.gameNum {
                    enterTieBreak()
                } else {
                    dealWithPosition(isGameDone: true)
                }
            } else {
                recordPointView.config.player1GameNum = 0
                recordPointView.config.player2GameNum = 0
                dealWithPosition(isGameDone: false)
                scoreSet(isLeft: isLeft)
            }
        }
    }

    func scoreSet(isLeft: Bool) {
        if isLeft {
            recordPointView.config.player1SetNum += 1
            if recordPointView.config.player1SetNum == game.setNum {
                game.endDate = Date().timeIntervalSince1970
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: leftBasicInfoView.config.name)
            }
        } else {
            recordPointView.config.player2SetNum += 1
            if recordPointView.config.player2SetNum == game.setNum {
                game.endDate = Date().timeIntervalSince1970
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: rightBasicInfoView.config.name)
            }
        }
    }

    func dealWithPosition(isGameDone: Bool) {
        /// 一盘结束，需要换边，把将要换边开关变成true，将要交换数据开关变成true，发球轮换
        if !isGameDone {
            if (livePoint[0] > livePoint[1]) == game.isPlayer1Serving {
                recordServeGameStatsUp(isPlayer1: true)
                recordReturnGameStatsDown(isPlayer1: false)
            } else {
                recordServeGameStatsDown(isPlayer1: true)
                recordReturnGameStatsUp(isPlayer1: false)
            }
            game.result[game.result.count - 1].append(livePoint)
            livePoint = [0, 0]
            game.result.append([])
            game.isPlayer1Serving.toggle()
            changeInfoViewPosition()
            TMDataConvert.changePosition(with: &recordPointView.config.player1GameNum, and: &recordPointView.config.player2GameNum)
            TMDataConvert.changePosition(with: &recordPointView.config.player1SetNum, and: &recordPointView.config.player2SetNum)
            game.isChangePosition = false
            game.isPlayer1Left.toggle()
        } else {
            if livePoint[0] > livePoint[1] {
                if game.isPlayer1Serving {
                    recordServeGameStatsUp(isPlayer1: true)
                    recordReturnGameStatsDown(isPlayer1: false)
                } else {
                    recordServeGameStatsDown(isPlayer1: false)
                    recordReturnGameStatsUp(isPlayer1: true)
                }
            } else {
                if game.isPlayer1Serving {
                    recordReturnGameStatsUp(isPlayer1: false)
                    recordServeGameStatsDown(isPlayer1: true)
                } else {
                    recordServeGameStatsUp(isPlayer1: false)
                    recordReturnGameStatsDown(isPlayer1: true)
                }
            }
            game.isPlayer1Serving.toggle()
            game.isChangePosition.toggle()
            if game.isChangePosition {
                changeInfoViewPosition()
                TMDataConvert.changePosition(with: &recordPointView.config.player1GameNum, and: &recordPointView.config.player2GameNum)
                TMDataConvert.changePosition(with: &recordPointView.config.player1SetNum, and: &recordPointView.config.player2SetNum)
                game.isPlayer1Left.toggle()
            }
            game.result[game.result.count - 1].append(livePoint)
            livePoint = [0, 0]
            print(game.result)
        }

        isServingOnLeft = game.isPlayer1Left == game.isPlayer1Serving
        updateDate()
    }

    func changeInfoViewPosition() {
        let tempIcon = leftBasicInfoView.config.icon
        leftBasicInfoView.config.icon = rightBasicInfoView.config.icon
        rightBasicInfoView.config.icon = tempIcon
        let tempName = leftBasicInfoView.config.name
        leftBasicInfoView.config.name = rightBasicInfoView.config.name
        rightBasicInfoView.config.name = tempName
    }

    func enterTieBreak() {
        game.isPlayer1Serving.toggle()
        if (livePoint[0] > livePoint[1]) == game.isPlayer1Serving {
            recordServeGameStatsUp(isPlayer1: true)
            recordReturnGameStatsDown(isPlayer1: false)
        } else {
            recordServeGameStatsDown(isPlayer1: true)
            recordReturnGameStatsUp(isPlayer1: false)
        }
        game.result[game.result.count - 1].append(livePoint)
        livePoint = [0, 0]
        isServingOnLeft = game.isPlayer1Left == game.isPlayer1Serving
        updateDate()
    }

    func changePositionInTieBreak() {
        var leftNum = (Int(recordPointView.config.player1PointNum) ?? 0)
        var rightNum = (Int(recordPointView.config.player2PointNum) ?? 0)
        if (leftNum + rightNum) % 2 != 0 {
            game.isPlayer1Serving.toggle()
        }
        if ((leftNum + rightNum) % 6) == 0 {
            game.isPlayer1Left.toggle()
            changeInfoViewPosition()
            TMDataConvert.changePosition(with: &leftNum, and: &rightNum)
            TMDataConvert.changePosition(with: &recordPointView.config.player1GameNum, and: &recordPointView.config.player2GameNum)
            TMDataConvert.changePosition(with: &recordPointView.config.player1SetNum, and: &recordPointView.config.player2SetNum)
            recordPointView.config.player1PointNum = "\(leftNum)"
            recordPointView.config.player2PointNum = "\(rightNum)"
        }

        isServingOnLeft = game.isPlayer1Left == game.isPlayer1Serving
        updateDate()
    }

    func updateDate() {
        leftBasicInfoView.updateInfo(with: leftBasicInfoView.config.icon, named: leftBasicInfoView.config.name)
        rightBasicInfoView.updateInfo(with: rightBasicInfoView.config.icon, named: rightBasicInfoView.config.name)
        recordPointView.updateLeftData(at: 2, isServingOnLeft: isServingOnLeft, newNum: recordPointView.config.player1PointNum)
        recordPointView.updateRightData(at: 2, isServingOnRight: !isServingOnLeft, newNum: recordPointView.config.player2PointNum)
        recordPointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "\(recordPointView.config.player1GameNum)")
        recordPointView.updateRightData(at: 1, isServingOnRight: false, newNum: "\(recordPointView.config.player2GameNum)")
        recordPointView.updateLeftData(at: 0, isServingOnLeft: false, newNum: "\(recordPointView.config.player1SetNum)")
        recordPointView.updateRightData(at: 0, isServingOnRight: false, newNum: "\(recordPointView.config.player2SetNum)")
    }

    func scoreUp(isLeft: Bool) {
        print("This is player1 stats \(player1Stats)")
        print("This is player2 stats \(player2Stats)")
        if isLeft == game.isPlayer1Left {
            livePoint[0] += 1
            print(livePoint)
        } else {
            livePoint[1] += 1
            print(livePoint)
        }
    }

    func scoreDowm(isLeft: Bool) {
        if isLeft == game.isPlayer1Left {
            livePoint[0] -= 1
            print(livePoint)
        } else {
            livePoint[1] -= 1
            print(livePoint)
        }
    }

    func saveGame() {
        game.result[game.result.count - 1].append(livePoint)
        game.player1Stats = player1Stats
        game.player2Stats = player2Stats
        TMGameRequest.updateGameAndStats(game: game) { _ in
            self.recordPointView.updateData(liveScore: self.game.result, isPlayer1Serving: self.game.isPlayer1Serving, isPlayer1Left: self.game.isPlayer1Left, setConfigNum: self.game.setNum, gameConfigNum: self.game.gameNum)
        }
    }

    func endGame() {
        game.endDate = Date().timeIntervalSince1970
        game.player1Stats = player1Stats
        game.player2Stats = player2Stats
        TMGameRequest.updateGameAndStats(game: game) { _ in
            self.recordPointView.updateData(liveScore: self.game.result, isPlayer1Serving: self.game.isPlayer1Serving, isPlayer1Left: self.game.isPlayer1Left, setConfigNum: self.game.setNum, gameConfigNum: self.game.gameNum)
        }
    }

    func recordStats(type: scoreBtnType, isLeft: Bool) {
        if game.isPlayer1Left {
            if game.isPlayer1Serving {
                if isLeft {
                    // player1在左侧发球加分
                    switch type {
                    case .ace:
                        player1Stats.aces += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .serveWinner:
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .serveFault:
                        player1Stats.servePoints += 1
                        if game.isPlayer1FirstServe {
                            player1Stats.firstServePoints += 1
                        }
                        game.isPlayer1FirstServe.toggle()
                        if game.isPlayer1FirstServe {
                            recordReturnStatsUp(isPlayer1: false)
                            recordBreakStatsUp(isPlayer1: false)
                            recordBreakStatsDowm(isPlayer1: true)
                        }
                    case .forehandWinner:
                        player1Stats.forehandWinners += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .backhandWinner:
                        player1Stats.backhandWinners += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .unforcedError:
                        player1Stats.unforcedErrors += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .netPoint:
                        player1Stats.netPoints += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    default:
                        break
                    }
                } else {
                    // player2在右侧接发加分
                    switch type {
                    case .returnAce:
                        player2Stats.returnAces += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .forehandWinner:
                        player2Stats.forehandWinners += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .backhandWinner:
                        player2Stats.backhandWinners += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .unforcedError:
                        player2Stats.unforcedErrors += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .netPoint:
                        player2Stats.netPoints += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    default:
                        break
                    }
                }
            } else {
                if isLeft {
                    // player1在左侧接发加分
                    switch type {
                    case .returnAce:
                        player1Stats.returnAces += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    case .forehandWinner:
                        player1Stats.forehandWinners += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    case .backhandWinner:
                        player1Stats.backhandWinners += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    case .unforcedError:
                        player1Stats.unforcedErrors += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .netPoint:
                        player1Stats.netPoints += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    default:
                        break
                    }
                } else {
                    // player2在右侧发球加分
                    switch type {
                    case .ace:
                        player2Stats.aces += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .serveWinner:
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .serveFault:
                        player2Stats.servePoints += 1
                        if game.isPlayer2FirstServe {
                            player2Stats.firstServePoints += 1
                        }
                        game.isPlayer2FirstServe.toggle()
                        if game.isPlayer2FirstServe {
                            recordReturnStatsUp(isPlayer1: true)
                            recordBreakStatsUp(isPlayer1: true)
                            recordBreakStatsDowm(isPlayer1: false)
                        }
                    case .forehandWinner:
                        player2Stats.forehandWinners += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .backhandWinner:
                        player2Stats.backhandWinners += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .unforcedError:
                        player2Stats.unforcedErrors += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .netPoint:
                        player2Stats.netPoints += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    default:
                        break
                    }
                }
            }
        } else {
            if game.isPlayer1Serving {
                if isLeft {
                    // player2在左侧接发加分
                    switch type {
                    case .returnAce:
                        player2Stats.returnAces += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .forehandWinner:
                        player2Stats.forehandWinners += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .backhandWinner:
                        player2Stats.backhandWinners += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .unforcedError:
                        player2Stats.unforcedErrors += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .netPoint:
                        player2Stats.netPoints += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    default:
                        break
                    }
                } else {
                    // player1在右侧发球加分
                    switch type {
                    case .ace:
                        player1Stats.aces += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .serveWinner:
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .serveFault:
                        player1Stats.servePoints += 1
                        if game.isPlayer1FirstServe {
                            player1Stats.firstServePoints += 1
                        }
                        game.isPlayer1FirstServe.toggle()
                        if game.isPlayer1FirstServe {
                            recordReturnStatsUp(isPlayer1: false)
                            recordBreakStatsUp(isPlayer1: false)
                            recordBreakStatsDowm(isPlayer1: true)
                        }
                    case .forehandWinner:
                        player1Stats.forehandWinners += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .backhandWinner:
                        player1Stats.backhandWinners += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    case .unforcedError:
                        player1Stats.unforcedErrors += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .netPoint:
                        player1Stats.netPoints += 1
                        recordServeStatsUp(isPlayer1: true)
                        recordReturnStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                    default:
                        break
                    }
                }
            } else {
                if isLeft {
                    // player2在左侧发球加分
                    switch type {
                    case .ace:
                        player2Stats.aces += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .serveWinner:
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .serveFault:
                        player2Stats.servePoints += 1
                        if game.isPlayer2FirstServe {
                            player2Stats.firstServePoints += 1
                        }
                        game.isPlayer2FirstServe.toggle()
                        if game.isPlayer2FirstServe {
                            recordReturnStatsUp(isPlayer1: true)
                            recordBreakStatsUp(isPlayer1: true)
                            recordBreakStatsDowm(isPlayer1: false)
                        }
                    case .forehandWinner:
                        player2Stats.forehandWinners += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .backhandWinner:
                        player2Stats.backhandWinners += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .unforcedError:
                        player2Stats.unforcedErrors += 1
                        recordServeStatsDown(isPlayer1: true)
                        recordReturnStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                    case .netPoint:
                        player2Stats.netPoints += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    default:
                        break
                    }
                } else {
                    // player1在右侧接发加分
                    switch type {
                    case .returnAce:
                        player1Stats.returnAces += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    case .forehandWinner:
                        player1Stats.forehandWinners += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    case .backhandWinner:
                        player1Stats.backhandWinners += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    case .unforcedError:
                        player1Stats.unforcedErrors += 1
                        recordServeStatsUp(isPlayer1: false)
                        recordReturnStatsDowm(isPlayer1: true)
                        recordBreakStatsUp(isPlayer1: false)
                        recordBreakStatsDowm(isPlayer1: true)
                    case .netPoint:
                        player1Stats.netPoints += 1
                        recordServeStatsDown(isPlayer1: false)
                        recordReturnStatsUp(isPlayer1: true)
                        recordBreakStatsDowm(isPlayer1: false)
                        recordBreakStatsUp(isPlayer1: true)
                    default:
                        break
                    }
                }
            }
        }
    }

    func recordServeStatsUp(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.servePoints += 1
            if game.isPlayer1FirstServe {
                player1Stats.firstServePoints += 1
                player1Stats.firstServePointsIn += 1
                player1Stats.firstServePointsWon += 1
            } else {
                player1Stats.secondServePointsIn += 1
                player1Stats.secondServePointsWon += 1
            }
        } else {
            player2Stats.servePoints += 1
            if game.isPlayer2FirstServe {
                player2Stats.firstServePoints += 1
                player2Stats.firstServePointsIn += 1
                player2Stats.firstServePointsWon += 1
            } else {
                player2Stats.secondServePointsIn += 1
                player2Stats.secondServePointsWon += 1
            }
        }
    }

    func recordReturnStatsUp(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.returnServePoints += 1
            if game.isPlayer2FirstServe {
                player1Stats.firstServeReturnPoints += 1
                player1Stats.firstServeReturnPointsIn += 1
                player1Stats.firstServeReturnPointsWon += 1
            } else {
                player1Stats.secondServeReturnPointsIn += 1
                player1Stats.secondServeReturnPointsWon += 1
                game.isPlayer2FirstServe.toggle()
            }
        } else {
            player2Stats.returnServePoints += 1
            if game.isPlayer1FirstServe {
                player2Stats.firstServeReturnPoints += 1
                player2Stats.firstServeReturnPointsIn += 1
                player2Stats.firstServeReturnPointsWon += 1
            } else {
                player2Stats.secondServeReturnPointsIn += 1
                player2Stats.secondServeReturnPointsWon += 1
                game.isPlayer1FirstServe.toggle()
            }
        }
    }

    func recordServeStatsDown(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.servePoints += 1
            if game.isPlayer1FirstServe {
                player1Stats.firstServePoints += 1
                player1Stats.firstServePointsIn += 1
            } else {
                player1Stats.secondServePointsIn += 1
            }
        } else {
            player2Stats.servePoints += 1
            if game.isPlayer2FirstServe {
                player2Stats.firstServePoints += 1
                player2Stats.firstServePointsIn += 1
            } else {
                player2Stats.secondServePointsIn += 1
            }
        }
    }

    func recordReturnStatsDowm(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.returnServePoints += 1
            if game.isPlayer2FirstServe {
                player1Stats.firstServeReturnPoints += 1
            } else {
                game.isPlayer2FirstServe.toggle()
            }
        } else {
            player2Stats.returnServePoints += 1
            if game.isPlayer1FirstServe {
                player2Stats.firstServeReturnPoints += 1
            } else {
                game.isPlayer1FirstServe.toggle()
            }
        }
    }

    func recordBreakStatsUp(isPlayer1: Bool) {
        let player1Num = game.isPlayer1Left == isPlayer1 ? recordPointView.config.player1PointNum.convertToNum() : recordPointView.config.player2PointNum.convertToNum()
        let player2Num = game.isPlayer1Left == !isPlayer1 ? recordPointView.config.player1PointNum.convertToNum() : recordPointView.config.player2PointNum.convertToNum()
        if isPlayer1 {
            if player2Num == 3, player1Num < 3 {
                player1Stats.breakPointsFaced += 1
                player1Stats.breakPointsSaved += 1
            } else if player2Num == 4, player1Num == 3 {
                player1Stats.breakPointsFaced += 1
                player1Stats.breakPointsSaved += 1
            } else if player1Num == 3, player2Num == 2 {
                player1Stats.breakPointsOpportunities += 1
                player1Stats.breakPointsConverted += 1
            } else if player1Num == 4, player2Num == 3 {
                player1Stats.breakPointsOpportunities += 1
                player1Stats.breakPointsConverted += 1
            }
        } else {
            if player1Num == 3, player2Num < 3 {
                player2Stats.breakPointsFaced += 1
                player2Stats.breakPointsSaved += 1
            } else if player1Num == 4, player2Num == 3 {
                player2Stats.breakPointsFaced += 1
                player2Stats.breakPointsSaved += 1
            } else if player2Num == 3, player1Num == 2 {
                player2Stats.breakPointsOpportunities += 1
                player2Stats.breakPointsConverted += 1
            } else if player2Num == 4, player1Num == 3 {
                player2Stats.breakPointsOpportunities += 1
                player2Stats.breakPointsConverted += 1
            }
        }
    }

    func recordBreakStatsDowm(isPlayer1: Bool) {
        let player1Num = game.isPlayer1Left == isPlayer1 ? recordPointView.config.player1PointNum.convertToNum() : recordPointView.config.player2PointNum.convertToNum()
        let player2Num = game.isPlayer1Left == !isPlayer1 ? recordPointView.config.player1PointNum.convertToNum() : recordPointView.config.player2PointNum.convertToNum()
        if isPlayer1 {
            if player2Num == 3, player1Num < 3 {
                player1Stats.breakPointsFaced += 1
            } else if player2Num == 4, player1Num == 3 {
                player1Stats.breakPointsFaced += 1
            } else if player1Num == 3, player2Num == 2 {
                player1Stats.breakPointsOpportunities += 1
            } else if player1Num == 4, player2Num == 3 {
                player1Stats.breakPointsOpportunities += 1
            }
        } else {
            if player1Num == 3, player2Num < 3 {
                player2Stats.breakPointsFaced += 1
            } else if player1Num == 4, player2Num == 3 {
                player2Stats.breakPointsFaced += 1
            } else if player2Num == 3, player1Num == 2 {
                player2Stats.breakPointsOpportunities += 1
            } else if player2Num == 4, player1Num == 3 {
                player2Stats.breakPointsOpportunities += 1
            }
        }
    }

    func recordServeGameStatsUp(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.serveGamesPlayed += 1
            player1Stats.serveGamesWon += 1
        } else {
            player2Stats.serveGamesPlayed += 1
            player2Stats.serveGamesWon += 1
        }
    }

    func recordServeGameStatsDown(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.serveGamesPlayed += 1
        } else {
            player2Stats.serveGamesPlayed += 1
        }
    }

    func recordReturnGameStatsUp(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.returnGamesPlayed += 1
            player1Stats.returnGamesWon += 1
        } else {
            player2Stats.returnGamesPlayed += 1
            player2Stats.returnGamesWon += 1
        }
    }

    func recordReturnGameStatsDown(isPlayer1: Bool) {
        if isPlayer1 {
            player1Stats.returnGamesPlayed += 1
        } else {
            player2Stats.returnGamesPlayed += 1
        }
    }
}

enum scoreBtnType: String {
    case ace
    case returnAce
    case serveWinner
    case serveFault
    case forehandWinner
    case backhandWinner
    case unforcedError
    case netPoint
}

enum scoreType: String {
    case aces
    case doubleFaults
    case servePoints
    case firstServePoints
    case firstServePointsIn
    case firstServePointsWon
    case secondServePointsWon
    case breakPointsFaced
    case breakPointsSaved
    case serveGamesPlayed
    case serveGamesWon
    case returnAces
    case returnServePoints
    case firstServeReturnPoints
    case firstServeReturnPointsWon
    case secondServeReturnPointsWon
    case breakPointsOpportunities
    case breakPointsConverted
    case returnGamesPlayed
    case returnGamesWon
    case netPoints
    case unforcedErrors
    case forehandWinners
    case backhandWinners
}
