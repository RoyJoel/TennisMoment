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
    var isChangeStats: Bool = false
    var isChangePosition: Bool = false
    var originalPositionOnleft: Bool = true
    var player1Stats = Stats(json: JSON())
    var player2Stats = Stats(json: JSON())
    var livePoint: [Int] = [0, 0]

    /// 左侧球员信息
    lazy var leftBasicInfoView: TMInfoView = {
        var view = TMInfoView()
        view.isUserInteractionEnabled = false
        return view
    }()

    /// 右侧球员信息
    lazy var rightBasicInfoView: TMInfoView = {
        var view = TMInfoView()
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

    func setupUI() {
        backgroundColor = UIColor(named: "TennisBlur")
        setCorner(radii: 15)

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

        leftBasicInfoView.frame = CGRect(x: 12, y: 27, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        rightBasicInfoView.frame = CGRect(x: bounds.width - leftBasicInfoView.bounds.width - 12, y: 27, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        recordPointView.frame = CGRect(x: (bounds.width / 2) - UIStandard.shared.screenWidth * 0.06, y: 27 + ((UIStandard.shared.screenHeight * 0.24 - 190) / 2), width: UIStandard.shared.screenWidth * 0.12, height: 190)

        let leftInfoConfig = TMInfoViewConfig(icon: "person", name: "player")
        let rightInfoConfig = TMInfoViewConfig(icon: "person", name: "player")
        let pointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 50, rowSpacing: 20, font: UIFont.systemFont(ofSize: 17), isTitleHidden: true, isPlayer1Serving: true, player1SetNum: 0, player2SetNum: 0, player1GameNum: 0, player2GameNum: 0, player1PointNum: "0", player2PointNum: "0")
        leftBasicInfoView.setup(with: leftInfoConfig)
        rightBasicInfoView.setup(with: rightInfoConfig)
        recordPointView.setup(with: pointRecordViewConfig)

        leftBasicInfoView.tab_startAnimation()
        rightBasicInfoView.tab_startAnimation()
        recordPointView.tab_startAnimation()
    }

    func setupEvent(game: Game) {
        self.game = game

        print(game.result)
        print(game.isPlayer1Serving)

        let count = game.result[game.result.count - 1].count
        isChangePosition = count % 2 == 0
        originalPositionOnleft = (count / 2) % 2 == 0

        if game.isPlayer1Serving != isChangePosition {
            recordPointView.config.isPlayer1Serving = false
        } else {
            recordPointView.config.isPlayer1Serving = true
        }

        DispatchQueue.global(qos: .userInitiated).async {
            TMPlayerRequest.searchPlayer(loginName: game.player1LoginName) { player1 in
                guard let player1 = player1 else {
                    return
                }
                TMPlayerRequest.searchPlayer(loginName: game.player2LoginName) { player2 in
                    guard let player2 = player2 else {
                        return
                    }
                    // 说明player1在左侧⬅️
                    if self.originalPositionOnleft {
                        self.leftBasicInfoView.updateInfo(with: player1.icon, named: player1.name)
                        self.rightBasicInfoView.updateInfo(with: player2.icon, named: player2.name)
                    } else {
                        self.leftBasicInfoView.updateInfo(with: player2.icon, named: player2.name)
                        self.rightBasicInfoView.updateInfo(with: player1.icon, named: player1.name)
                    }
                    self.recordPointView.updateData(liveScore: game.result, isPlayer1Serving: game.isPlayer1Serving, isChangePosition: (count / 2) % 2 != 0, setConfigNum: game.setNum, gameConfigNum: game.gameNum)
                    self.livePoint = self.game.result[game.result.count - 1].removeLast()
                    self.leftBasicInfoView.tab_endAnimationEaseOut()
                    self.rightBasicInfoView.tab_endAnimationEaseOut()
                    self.recordPointView.tab_endAnimationEaseOut()
                }
            }

            TMStatsRequest.searchStats(id: game.player1StatsId) { player1Stats in
                TMStatsRequest.searchStats(id: game.player2StatsId) { player2Stats in
                    self.player1Stats = player1Stats
                    self.player2Stats = player2Stats
                }
            }
        }
    }

    func recordNewGame(game: Game) {
        setupEvent(game: game)
    }

    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
        if isEnlarge {
            leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
            rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
            recordPointView.scaleTo(recordPointView.toggle)

            recordPointView.scaleTo(newRowHeight: 50, newRowSpacing: 20, newFont: UIFont.systemFont(ofSize: 17), isTitleHidden: true, originalPositionOnleft: originalPositionOnleft)

            leftScoreControllerView.isHidden = true
            rightScoreControllerView.isHidden = true
        } else {
            leftBasicInfoView.setup(leftBasicInfoView.bounds, leftBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: 24 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
            rightBasicInfoView.setup(rightBasicInfoView.bounds, rightBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: UIStandard.shared.screenWidth - 24 - UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
            recordPointView.setup(recordPointView.bounds, recordPointView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.4, height: UIStandard.shared.screenWidth * 0.25), CGPoint(x: UIStandard.shared.screenWidth * 0.5, y: 104 + UIStandard.shared.screenHeight * 0.15), 0.3)

            leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
            rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
            recordPointView.scaleTo(recordPointView.toggle)

            recordPointView.scaleTo(newRowHeight: 70, newRowSpacing: 40, newFont: UIFont.systemFont(ofSize: 24), isTitleHidden: false, originalPositionOnleft: originalPositionOnleft)

            leftScoreControllerView.setupUI(isLeft: true)
            rightScoreControllerView.setupUI(isLeft: false)

            leftScoreControllerView.frame = CGRect(x: 40, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)
            rightScoreControllerView.frame = CGRect(x: UIStandard.shared.screenWidth - 40 - UIStandard.shared.screenHeight * 0.46, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)

            leftScoreControllerView.isHidden = false
            rightScoreControllerView.isHidden = false
        }
    }

    @objc func player1AceBtnTap() {
        scorePoint(isLeft: true)
        recordStats(scoreType: .aces, isLeft: true)
        recordStats(scoreType: .servePoints, isLeft: true)
        if game.isPlayer1FirstServe {
            recordStats(scoreType: .firstServePoints, isLeft: true)
            recordStats(scoreType: .firstServePointsIn, isLeft: true)
            recordStats(scoreType: .firstServePointsWon, isLeft: true)
        }
    }

    @objc func player1ServeScoreBtnTap() {
        recordStats(scoreType: .servePoints, isLeft: true)
        scorePoint(isLeft: true)
        if game.isPlayer1FirstServe {
            recordStats(scoreType: .firstServePoints, isLeft: true)
            recordStats(scoreType: .firstServePointsIn, isLeft: true)
            recordStats(scoreType: .firstServePointsWon, isLeft: true)
        } else {
            recordStats(scoreType: .secondServePointsWon, isLeft: true)
        }
    }

    @objc func player1ServeFaultBtnTap() {
        recordStats(scoreType: .servePoints, isLeft: true)
        game.isPlayer1FirstServe.toggle()
        if game.isPlayer1FirstServe {
            recordStats(scoreType: .doubleFaults, isLeft: true)
            scorePoint(isLeft: false)
        }
    }

    @objc func player1ReturnAceBtnTap() {
        recordStats(scoreType: .returnAces, isLeft: true)
        recordStats(scoreType: .returnServePoints, isLeft: true)
        scorePoint(isLeft: true)
        if game.isPlayer2FirstServe {
            recordStats(scoreType: .firstServeReturnPoints, isLeft: true)
            recordStats(scoreType: .firstServeReturnPointsWon, isLeft: true)
        }
    }

    @objc func player1UnforceErrorBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .servePoints, isLeft: true)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: true)
                recordStats(scoreType: .firstServePointsIn, isLeft: true)
            }
        } else {
            recordStats(scoreType: .returnServePoints, isLeft: true)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: true)
            }
        }
        recordStats(scoreType: .unforcedErrors, isLeft: true)
        scorePoint(isLeft: false)
    }

    @objc func player1ForehandWinnersBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .servePoints, isLeft: true)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: true)
                recordStats(scoreType: .firstServePointsIn, isLeft: true)
                recordStats(scoreType: .firstServePointsWon, isLeft: true)
            } else {
                recordStats(scoreType: .secondServePointsWon, isLeft: true)
            }
        } else {
            recordStats(scoreType: .returnServePoints, isLeft: true)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: true)
                recordStats(scoreType: .firstServeReturnPointsWon, isLeft: true)
            } else {
                recordStats(scoreType: .secondServeReturnPointsWon, isLeft: true)
            }
        }
        scorePoint(isLeft: true)
        recordStats(scoreType: .forehandWinners, isLeft: true)
    }

    @objc func player1BackhandWinnersBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .servePoints, isLeft: true)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: true)
                recordStats(scoreType: .firstServePointsIn, isLeft: true)
                recordStats(scoreType: .firstServePointsWon, isLeft: true)
            } else {
                recordStats(scoreType: .secondServePointsWon, isLeft: true)
            }
        } else {
            recordStats(scoreType: .returnServePoints, isLeft: true)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: true)
                recordStats(scoreType: .firstServeReturnPointsWon, isLeft: true)
            } else {
                recordStats(scoreType: .secondServeReturnPointsWon, isLeft: true)
            }
        }
        scorePoint(isLeft: true)
        recordStats(scoreType: .backhandWinners, isLeft: true)
    }

    @objc func player1NetPointBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .servePoints, isLeft: true)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: true)
                recordStats(scoreType: .firstServePointsIn, isLeft: true)
                recordStats(scoreType: .firstServePointsWon, isLeft: true)
            } else {
                recordStats(scoreType: .secondServePointsWon, isLeft: true)
            }
        } else {
            recordStats(scoreType: .returnServePoints, isLeft: true)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: true)
                recordStats(scoreType: .firstServeReturnPointsWon, isLeft: true)
            } else {
                recordStats(scoreType: .secondServeReturnPointsWon, isLeft: true)
            }
        }
        scorePoint(isLeft: true)
        recordStats(scoreType: .netPoints, isLeft: true)
    }

    @objc func player2AceBtnTap() {
        scorePoint(isLeft: false)
        recordStats(scoreType: .aces, isLeft: false)
        recordStats(scoreType: .servePoints, isLeft: false)
        if game.isPlayer2FirstServe {
            recordStats(scoreType: .firstServePoints, isLeft: false)
            recordStats(scoreType: .firstServePointsIn, isLeft: false)
            recordStats(scoreType: .firstServePointsWon, isLeft: false)
        }
    }

    @objc func player2ServeScoreBtnTap() {
        recordStats(scoreType: .servePoints, isLeft: false)
        scorePoint(isLeft: false)
        if game.isPlayer2FirstServe {
            recordStats(scoreType: .firstServePoints, isLeft: false)
            recordStats(scoreType: .firstServePointsIn, isLeft: false)
            recordStats(scoreType: .firstServePointsWon, isLeft: false)
        } else {
            recordStats(scoreType: .secondServePointsWon, isLeft: false)
        }
    }

    @objc func player2ServeFaultBtnTap() {
        recordStats(scoreType: .servePoints, isLeft: false)
        game.isPlayer1FirstServe.toggle()
        if game.isPlayer2FirstServe {
            recordStats(scoreType: .doubleFaults, isLeft: false)
            scorePoint(isLeft: true)
        }
    }

    @objc func player2ReturnAceBtnTap() {
        recordStats(scoreType: .returnAces, isLeft: false)
        recordStats(scoreType: .returnServePoints, isLeft: false)
        scorePoint(isLeft: false)
        if game.isPlayer2FirstServe {
            recordStats(scoreType: .firstServeReturnPoints, isLeft: false)
            recordStats(scoreType: .firstServeReturnPointsWon, isLeft: false)
        }
    }

    @objc func player2UnforceErrorBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .returnServePoints, isLeft: false)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: false)
            }
        } else {
            recordStats(scoreType: .servePoints, isLeft: false)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: false)
                recordStats(scoreType: .firstServePointsIn, isLeft: false)
            }
        }
        recordStats(scoreType: .unforcedErrors, isLeft: false)
        scorePoint(isLeft: true)
    }

    @objc func player2ForehandWinnersBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .returnServePoints, isLeft: false)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: false)
                recordStats(scoreType: .firstServeReturnPointsWon, isLeft: false)
            } else {
                recordStats(scoreType: .secondServeReturnPointsWon, isLeft: false)
            }
        } else {
            recordStats(scoreType: .servePoints, isLeft: false)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: false)
                recordStats(scoreType: .firstServePointsIn, isLeft: false)
                recordStats(scoreType: .firstServePointsWon, isLeft: false)
            } else {
                recordStats(scoreType: .secondServePointsWon, isLeft: false)
            }
        }
        scorePoint(isLeft: false)
        recordStats(scoreType: .forehandWinners, isLeft: false)
    }

    @objc func player2BackhandWinnersBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .returnServePoints, isLeft: false)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: false)
                recordStats(scoreType: .firstServeReturnPointsWon, isLeft: false)
            } else {
                recordStats(scoreType: .secondServeReturnPointsWon, isLeft: false)
            }
        } else {
            recordStats(scoreType: .servePoints, isLeft: false)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: false)
                recordStats(scoreType: .firstServePointsIn, isLeft: false)
                recordStats(scoreType: .firstServePointsWon, isLeft: false)
            } else {
                recordStats(scoreType: .secondServePointsWon, isLeft: false)
            }
        }
        scorePoint(isLeft: false)
        recordStats(scoreType: .backhandWinners, isLeft: false)
    }

    @objc func player2NetPointBtnTap() {
        if game.isPlayer1Serving {
            recordStats(scoreType: .returnServePoints, isLeft: false)
            if game.isPlayer2FirstServe {
                recordStats(scoreType: .firstServeReturnPoints, isLeft: false)
                recordStats(scoreType: .firstServeReturnPointsWon, isLeft: false)
            } else {
                recordStats(scoreType: .secondServeReturnPointsWon, isLeft: false)
            }
        } else {
            recordStats(scoreType: .servePoints, isLeft: false)
            if game.isPlayer1FirstServe {
                recordStats(scoreType: .firstServePoints, isLeft: false)
                recordStats(scoreType: .firstServePointsIn, isLeft: false)
                recordStats(scoreType: .firstServePointsWon, isLeft: false)
            } else {
                recordStats(scoreType: .secondServePointsWon, isLeft: false)
            }
        }
        scorePoint(isLeft: false)
        recordStats(scoreType: .netPoints, isLeft: false)
    }

    func scorePoint(isLeft: Bool) {
        if recordPointView.config.player1GameNum == game.gameNum, recordPointView.config.player2GameNum == game.gameNum {
            scoreTieBreakPoint(isLeft: isLeft)
        } else {
            if isLeft {
                switch recordPointView.config.player1PointNum {
                case "0":
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "15")
                    recordPointView.config.player1PointNum = "15"
                    scoreUp(isLeft: isLeft)
                case "15":
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "30")
                    recordPointView.config.player1PointNum = "30"
                    scoreUp(isLeft: isLeft)
                case "30":
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "40")
                    recordPointView.config.player1PointNum = "40"
                    scoreUp(isLeft: isLeft)
                case "40":
                    if recordPointView.config.player2PointNum == "40" {
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "AD")
                        recordPointView.config.player1PointNum = "AD"
                        scoreUp(isLeft: isLeft)
                    } else if recordPointView.config.player2PointNum == "AD" {
                        if game.isPlayer1Serving {
                            if recordPointView.config.player2PointNum == "40" {
                                recordStats(scoreType: .breakPointsFaced, isLeft: false)
                                recordStats(scoreType: .breakPointsSaved, isLeft: false)
                                recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                            }
                        } else {
                            if recordPointView.config.player1PointNum == "40" {
                                recordStats(scoreType: .breakPointsFaced, isLeft: true)
                                recordStats(scoreType: .breakPointsSaved, isLeft: true)
                                recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                            }
                        }
                        recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "40")
                        recordPointView.config.player2PointNum = "40"
                        scoreDowm(isLeft: !isLeft)
                    } else {
                        if !game.isPlayer1Serving {
                            recordStats(scoreType: .breakPointsConverted, isLeft: false)
                            recordStats(scoreType: .returnGamesPlayed, isLeft: false)
                            recordStats(scoreType: .returnGamesWon, isLeft: false)
                        } else {
                            recordStats(scoreType: .breakPointsConverted, isLeft: true)
                            recordStats(scoreType: .returnGamesPlayed, isLeft: true)
                            recordStats(scoreType: .returnGamesWon, isLeft: true)
                        }
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "0")
                        recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "0")
                        recordPointView.config.player1PointNum = "0"
                        recordPointView.config.player2PointNum = "0"
                        scoreUp(isLeft: isLeft)
                        scoreUp(isLeft: isLeft)
                        scoreGame(isLeft: isLeft)
                    }
                case "AD":
                    if !game.isPlayer1Serving {
                        recordStats(scoreType: .breakPointsConverted, isLeft: false)
                        recordStats(scoreType: .returnGamesPlayed, isLeft: false)
                        recordStats(scoreType: .returnGamesWon, isLeft: false)
                    } else {
                        recordStats(scoreType: .breakPointsConverted, isLeft: true)
                        recordStats(scoreType: .returnGamesPlayed, isLeft: true)
                        recordStats(scoreType: .returnGamesWon, isLeft: true)
                    }
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "0")
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "0")
                    recordPointView.config.player1PointNum = "0"
                    recordPointView.config.player2PointNum = "0"
                    scoreUp(isLeft: isLeft)
                    scoreGame(isLeft: isLeft)
                default:
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "0")
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "0")
                }
            } else {
                switch recordPointView.config.player2PointNum {
                case "0":
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "15")
                    recordPointView.config.player2PointNum = "15"
                    scoreUp(isLeft: isLeft)
                case "15":
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "30")
                    recordPointView.config.player2PointNum = "30"
                    scoreUp(isLeft: isLeft)
                case "30":
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "40" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "40")
                    recordPointView.config.player2PointNum = "40"
                    scoreUp(isLeft: isLeft)
                case "40":
                    if recordPointView.config.player1PointNum == "40" {
                        recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "AD")
                        recordPointView.config.player2PointNum = "AD"
                        scoreUp(isLeft: isLeft)
                    } else if recordPointView.config.player1PointNum == "AD" {
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "40")
                        recordPointView.config.player1PointNum = "40"
                        scoreDowm(isLeft: !isLeft)
                    } else {
                        if !game.isPlayer1Serving {
                            recordStats(scoreType: .breakPointsConverted, isLeft: false)
                            recordStats(scoreType: .returnGamesPlayed, isLeft: false)
                            recordStats(scoreType: .returnGamesWon, isLeft: false)
                        } else {
                            recordStats(scoreType: .breakPointsConverted, isLeft: true)
                            recordStats(scoreType: .returnGamesPlayed, isLeft: true)
                            recordStats(scoreType: .returnGamesWon, isLeft: true)
                        }
                        recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "0")
                        recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "0")
                        recordPointView.config.player1PointNum = "0"
                        recordPointView.config.player2PointNum = "0"
                        scoreUp(isLeft: isLeft)
                        scoreUp(isLeft: isLeft)
                        scoreGame(isLeft: isLeft)
                    }
                case "AD":
                    if !game.isPlayer1Serving {
                        recordStats(scoreType: .breakPointsConverted, isLeft: false)
                        recordStats(scoreType: .returnGamesPlayed, isLeft: false)
                        recordStats(scoreType: .returnGamesWon, isLeft: false)
                    } else {
                        recordStats(scoreType: .breakPointsConverted, isLeft: true)
                        recordStats(scoreType: .returnGamesPlayed, isLeft: true)
                        recordStats(scoreType: .returnGamesWon, isLeft: true)
                    }
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "0")
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "0")
                    recordPointView.config.player1PointNum = "0"
                    recordPointView.config.player2PointNum = "0"
                    scoreUp(isLeft: isLeft)
                    scoreGame(isLeft: isLeft)
                default:
                    recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: "0")
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: "0")
                }
            }
        }
    }

    func scoreTieBreakPoint(isLeft: Bool) {
        if isLeft {
            let point = Int(recordPointView.config.player1PointNum) ?? 0
            if point < 6 {
                if game.isPlayer1Serving {
                    if recordPointView.config.player2PointNum == "6" {
                        recordStats(scoreType: .breakPointsFaced, isLeft: false)
                        recordStats(scoreType: .breakPointsSaved, isLeft: false)
                        recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                    }
                } else {
                    if recordPointView.config.player1PointNum == "6" {
                        recordStats(scoreType: .breakPointsFaced, isLeft: true)
                        recordStats(scoreType: .breakPointsSaved, isLeft: true)
                        recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                    }
                }
                recordPointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "\(point + 1)")
                recordPointView.config.player1PointNum = "\(point + 1)"
                scoreUp(isLeft: isLeft)
                changePositionInTieBreak()
            } else {
                if point - (Int(recordPointView.config.player2PointNum) ?? 0) < 1 {
                    recordPointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "\(point + 1)")
                    recordPointView.config.player1PointNum = "\(point + 1)"
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "\(point + 1)" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "\(point + 1)" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    scoreUp(isLeft: isLeft)
                    changePositionInTieBreak()
                } else {
                    if !game.isPlayer1Serving {
                        if recordPointView.config.player1PointNum == "\(point + 1)" {
                            recordStats(scoreType: .breakPointsConverted, isLeft: true)
                            recordStats(scoreType: .returnGamesPlayed, isLeft: true)
                            recordStats(scoreType: .returnGamesWon, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player2PointNum == "\(point + 1)" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    }
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
                if game.isPlayer1Serving {
                    if recordPointView.config.player2PointNum == "6" {
                        recordStats(scoreType: .breakPointsFaced, isLeft: false)
                        recordStats(scoreType: .breakPointsSaved, isLeft: false)
                        recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                    }
                } else {
                    if recordPointView.config.player1PointNum == "6" {
                        recordStats(scoreType: .breakPointsFaced, isLeft: true)
                        recordStats(scoreType: .breakPointsSaved, isLeft: true)
                        recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                    }
                }
                recordPointView.updateRightData(at: 2, isServingOnRight: false, newNum: "\(point + 1)")
                recordPointView.config.player2PointNum = "\(point + 1)"
                scoreUp(isLeft: isLeft)
                changePositionInTieBreak()
            } else {
                if point - (Int(recordPointView.config.player1PointNum) ?? 0) < 1 {
                    recordPointView.updateRightData(at: 2, isServingOnRight: false, newNum: "\(point + 1)")
                    recordPointView.config.player2PointNum = "\(point + 1)"
                    if game.isPlayer1Serving {
                        if recordPointView.config.player2PointNum == "\(point + 1)" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: false)
                            recordStats(scoreType: .breakPointsSaved, isLeft: false)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: true)
                        }
                    } else {
                        if recordPointView.config.player1PointNum == "\(point + 1)" {
                            recordStats(scoreType: .breakPointsFaced, isLeft: true)
                            recordStats(scoreType: .breakPointsSaved, isLeft: true)
                            recordStats(scoreType: .breakPointsOpportunities, isLeft: false)
                        }
                    }
                    scoreUp(isLeft: isLeft)
                    changePositionInTieBreak()
                } else {
                    if !game.isPlayer1Serving {
                        recordStats(scoreType: .breakPointsConverted, isLeft: false)
                        recordStats(scoreType: .returnGamesPlayed, isLeft: false)
                        recordStats(scoreType: .returnGamesWon, isLeft: false)
                    } else {
                        recordStats(scoreType: .breakPointsConverted, isLeft: true)
                        recordStats(scoreType: .returnGamesPlayed, isLeft: true)
                        recordStats(scoreType: .returnGamesWon, isLeft: true)
                    }
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
                dealWithPosition(isGameDone: true)
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
                dealWithPosition(isGameDone: true)
            } else {
                recordPointView.config.player1GameNum = 0
                recordPointView.config.player2GameNum = 0
                scoreSet(isLeft: isLeft)
                dealWithPosition(isGameDone: false)
            }
        }
    }

    func scoreSet(isLeft: Bool) {
        if isLeft {
            recordPointView.config.player1SetNum += 1
            if recordPointView.config.player1SetNum == game.setNum {
                game.isCompleted = true
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: leftBasicInfoView.config.name)
            }
        } else {
            recordPointView.config.player2SetNum += 1
            if recordPointView.config.player2SetNum == game.setNum {
                game.isCompleted = true
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: rightBasicInfoView.config.name)
            }
        }
    }

    func dealWithPosition(isGameDone: Bool) {
        isChangePosition.toggle()
        game.isPlayer1Serving.toggle()
        recordPointView.config.isPlayer1Serving.toggle()

        if isChangeStats {
            livePoint.swapAt(0, 1)
        }

        game.result[game.result.count - 1].append(livePoint)
        livePoint = [0, 0]

        if !isGameDone {
            game.result.append([])
            isChangePosition = false
            changeInfoViewPosition()
            TMDataConvert.changePosition(with: &recordPointView.config.player1GameNum, and: &recordPointView.config.player2GameNum)
            TMDataConvert.changePosition(with: &recordPointView.config.player1SetNum, and: &recordPointView.config.player2SetNum)
        } else {
            if isChangePosition {
                isChangeStats.toggle()
                recordPointView.config.isPlayer1Serving.toggle()
                changeInfoViewPosition()
                TMDataConvert.changePosition(with: &recordPointView.config.player1GameNum, and: &recordPointView.config.player2GameNum)
                TMDataConvert.changePosition(with: &recordPointView.config.player1SetNum, and: &recordPointView.config.player2SetNum)
            }
        }
        print(game.isPlayer1Serving)
        print(game.result)
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

    func changePositionInTieBreak() {
        var leftNum = (Int(recordPointView.config.player1PointNum) ?? 0)
        var rightNum = (Int(recordPointView.config.player2PointNum) ?? 0)
        isChangePosition.toggle()
        if isChangePosition {
            game.isPlayer1Serving.toggle()
            recordPointView.config.isPlayer1Serving.toggle()
        }
        if ((leftNum + rightNum) % 6) == 0 {
            changeInfoViewPosition()
            livePoint.swapAt(0, 1)
            TMDataConvert.changePosition(with: &leftNum, and: &rightNum)
            TMDataConvert.changePosition(with: &recordPointView.config.player1GameNum, and: &recordPointView.config.player2GameNum)
            TMDataConvert.changePosition(with: &recordPointView.config.player1SetNum, and: &recordPointView.config.player2SetNum)
        }
        recordPointView.config.player1PointNum = "\(leftNum)"
        recordPointView.config.player2PointNum = "\(rightNum)"
        updateDate()
    }

    func updateDate() {
        leftBasicInfoView.updateInfo(with: leftBasicInfoView.config.icon, named: leftBasicInfoView.config.name)
        rightBasicInfoView.updateInfo(with: rightBasicInfoView.config.icon, named: rightBasicInfoView.config.name)
        recordPointView.updateLeftData(at: 2, isServingOnLeft: recordPointView.config.isPlayer1Serving, newNum: recordPointView.config.player1PointNum)
        recordPointView.updateRightData(at: 2, isServingOnRight: !recordPointView.config.isPlayer1Serving, newNum: recordPointView.config.player2PointNum)
        recordPointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "\(recordPointView.config.player1GameNum)")
        recordPointView.updateRightData(at: 1, isServingOnRight: false, newNum: "\(recordPointView.config.player2GameNum)")
        recordPointView.updateLeftData(at: 0, isServingOnLeft: false, newNum: "\(recordPointView.config.player1SetNum)")
        recordPointView.updateRightData(at: 0, isServingOnRight: false, newNum: "\(recordPointView.config.player2SetNum)")
    }

    func scoreUp(isLeft: Bool) {
        if isLeft {
            livePoint[0] += 1
            print(livePoint)
        } else {
            livePoint[1] += 1
            print(livePoint)
        }
    }

    func scoreDowm(isLeft: Bool) {
        var count = 0
        for set in game.result {
            for _ in set {
                count += 1
            }
        }

        if ((count / 2) % 2 != 0) != isLeft {
            livePoint[0] -= 1
            print(livePoint)
        } else {
            livePoint[1] -= 1
            print(livePoint)
        }
    }

    func recordStats(scoreType: scoreType, isLeft: Bool) {
        switch scoreType {
        case .aces:
            if isChangePosition != isLeft {
                player1Stats.aces += 1
            } else {
                player2Stats.aces += 1
            }
        case .doubleFaults:
            if isChangePosition != isLeft {
                player1Stats.doubleFaults += 1
            } else {
                player2Stats.doubleFaults += 1
            }
        case .firstServePoints:
            if isChangePosition != isLeft {
                player1Stats.firstServePoints += 1
            } else {
                player2Stats.firstServePoints += 1
            }
        case .firstServePointsIn:
            if isChangePosition != isLeft {
                player1Stats.firstServePointsIn += 1
            } else {
                player2Stats.firstServePointsIn += 1
            }
        case .firstServePointsWon:
            if isChangePosition != isLeft {
                player1Stats.firstServePointsWon += 1
            } else {
                player2Stats.firstServePointsWon += 1
            }
        case .secondServePointsWon:
            if isChangePosition != isLeft {
                player1Stats.secondServePointsWon += 1
            } else {
                player2Stats.secondServePointsWon += 1
            }
        case .breakPointsFaced:
            if isChangePosition != isLeft {
                player1Stats.breakPointsFaced += 1
            } else {
                player2Stats.breakPointsFaced += 1
            }
        case .breakPointsSaved:
            if isChangePosition != isLeft {
                player1Stats.breakPointsSaved += 1
            } else {
                player2Stats.breakPointsSaved += 1
            }
        case .serveGamesPlayed:
            if isChangePosition != isLeft {
                player1Stats.serveGamesPlayed += 1
            } else {
                player2Stats.serveGamesPlayed += 1
            }
        case .serveGamesWon:
            if isChangePosition != isLeft {
                player1Stats.serveGamesWon += 1
            } else {
                player2Stats.serveGamesWon += 1
            }
        case .firstServeReturnPoints:
            if isChangePosition != isLeft {
                player1Stats.firstServeReturnPoints += 1
            } else {
                player2Stats.firstServeReturnPoints += 1
            }
        case .firstServeReturnPointsWon:
            if isChangePosition != isLeft {
                player1Stats.firstServeReturnPointsWon += 1
            } else {
                player2Stats.firstServeReturnPointsWon += 1
            }
        case .secondServeReturnPointsWon:
            if isChangePosition != isLeft {
                player1Stats.secondServeReturnPointsWon += 1
            } else {
                player2Stats.secondServeReturnPointsWon += 1
            }
        case .breakPointsOpportunities:
            if isChangePosition != isLeft {
                player1Stats.breakPointsOpportunities += 1
            } else {
                player2Stats.breakPointsOpportunities += 1
            }
        case .breakPointsConverted:
            if isChangePosition != isLeft {
                player1Stats.breakPointsConverted += 1
            } else {
                player2Stats.breakPointsConverted += 1
            }
        case .returnGamesPlayed:
            if isChangePosition != isLeft {
                player1Stats.returnGamesPlayed += 1
            } else {
                player2Stats.returnGamesPlayed += 1
            }
        case .returnGamesWon:
            if isChangePosition != isLeft {
                player1Stats.returnGamesWon += 1
            } else {
                player2Stats.returnGamesWon += 1
            }
        case .netPoints:
            if isChangePosition != isLeft {
                player1Stats.netPoints += 1
            } else {
                player2Stats.netPoints += 1
            }
        case .unforcedErrors:
            if isChangePosition != isLeft {
                player1Stats.unforcedErrors += 1
            } else {
                player2Stats.unforcedErrors += 1
            }
        case .forehandWinners:
            if isChangePosition != isLeft {
                player1Stats.forehandWinners += 1
            } else {
                player2Stats.forehandWinners += 1
            }
        case .backhandWinners:
            if isChangePosition != isLeft {
                player1Stats.backhandWinners += 1
            } else {
                player2Stats.backhandWinners += 1
            }
        case .servePoints:
            if isChangePosition != isLeft {
                player1Stats.servePoints += 1
            } else {
                player2Stats.servePoints += 1
            }
        case .returnAces:
            if isChangePosition != isLeft {
                player1Stats.returnAces += 1
            } else {
                player2Stats.returnAces += 1
            }
        case .returnServePoints:
            if isChangePosition != isLeft {
                player1Stats.returnServePoints += 1
            } else {
                player2Stats.returnServePoints += 1
            }
        }
    }

    func saveGame(isCompleted: Bool) {
        if isChangeStats {
            livePoint.swapAt(0, 1)
        }
        if !isCompleted {
            game.result[game.result.count - 1].append(livePoint)
        } else {
            game.isCompleted = true
        }
        TMGameRequest.updateGame(game: game) { _ in
            TMStatsRequest.updateStats(stats: self.player1Stats) { _ in
                TMStatsRequest.updateStats(stats: self.player2Stats) { _ in
                }
            }
        }
        livePoint = game.result[game.result.count - 1].removeLast()
    }
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
