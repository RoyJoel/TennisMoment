//
//  scoreControllerView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import TMComponent
import Toast_Swift
import UIKit

class scoreControllerView: UIView {
    var isLeft: Bool = true
    var relatedPointRecordView = TMPointRecordView()
    var relatedInfoView = TMInfoView()

    lazy var aceBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var serveScoreBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var serveFaultBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var returnAceBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var unforcedErrorBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var forehandWinnersBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var backhandWinnersBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var netPointBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    func setupUI(isLeft: Bool, relatedPointRecordView: TMPointRecordView, relatedInfoView: TMInfoView) {
        self.isLeft = isLeft
        self.relatedPointRecordView = relatedPointRecordView
        self.relatedInfoView = relatedInfoView

        addSubview(aceBtn)
        addSubview(serveScoreBtn)
        addSubview(serveFaultBtn)
        addSubview(returnAceBtn)
        addSubview(unforcedErrorBtn)
        addSubview(forehandWinnersBtn)
        addSubview(backhandWinnersBtn)
        addSubview(netPointBtn)

        let aceBtnConfig = TMButtonConfig(title: "ACE", action: #selector(aceBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let serveScoreBtnConfig = TMButtonConfig(title: "SERVE WINNER", action: #selector(serveScoreBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let serveFaultBtnConfig = TMButtonConfig(title: "SERVE  FAULT", action: #selector(serveFaultBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let returnAceBtnConfig = TMButtonConfig(title: "RETURN  ACE", action: #selector(returnAceBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let unforcedErrorBtnConfig = TMButtonConfig(title: "UNFORCE ERROR", action: #selector(unforceErrorBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let forehandWinnersBtnConfig = TMButtonConfig(title: "FOREHAND WINNER", action: #selector(forehandWinnersBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let backhandWinnersBtnConfig = TMButtonConfig(title: "BACKHAND WINNER", action: #selector(forehandWinnersBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)
        let netPointBtnConfig = TMButtonConfig(title: "NET POINT", action: #selector(netPointBtnTap(_:)), actionTarget: self, relatedPointRecordView: relatedPointRecordView, relatedInfoView: relatedInfoView)

        aceBtn.setUp(with: aceBtnConfig)
        serveScoreBtn.setUp(with: serveScoreBtnConfig)
        serveFaultBtn.setUp(with: serveFaultBtnConfig)
        returnAceBtn.setUp(with: returnAceBtnConfig)
        unforcedErrorBtn.setUp(with: unforcedErrorBtnConfig)
        forehandWinnersBtn.setUp(with: forehandWinnersBtnConfig)
        backhandWinnersBtn.setUp(with: backhandWinnersBtnConfig)
        netPointBtn.setUp(with: netPointBtnConfig)

        let largeBtnWidth = (UIStandard.shared.screenHeight * 0.46 - 50) / 3
        let largeBtnHeight = (UIStandard.shared.screenWidth * 0.25 - 40) / 2
        let smallBtnHeight = (largeBtnHeight - 10) / 2

        if isLeft {
            aceBtn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.left.equalToSuperview().offset(15)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            serveScoreBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.left.equalTo(aceBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            serveFaultBtn.snp.makeConstraints { make in
                make.top.equalTo(serveScoreBtn.snp.bottom).offset(10)
                make.left.equalTo(serveScoreBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            returnAceBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.left.equalTo(serveScoreBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            unforcedErrorBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(aceBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            forehandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(unforcedErrorBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            backhandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(forehandWinnersBtn.snp.bottom).offset(10)
                make.left.equalTo(forehandWinnersBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            netPointBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(forehandWinnersBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
        } else {
            aceBtn.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            serveScoreBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.right.equalTo(aceBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            serveFaultBtn.snp.makeConstraints { make in
                make.top.equalTo(serveScoreBtn.snp.bottom).offset(10)
                make.right.equalTo(serveScoreBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            returnAceBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.top)
                make.right.equalTo(serveScoreBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            unforcedErrorBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(aceBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            forehandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(unforcedErrorBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            backhandWinnersBtn.snp.makeConstraints { make in
                make.top.equalTo(forehandWinnersBtn.snp.bottom).offset(10)
                make.right.equalTo(forehandWinnersBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(smallBtnHeight)
            }
            netPointBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(forehandWinnersBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
        }
    }

    @objc func aceBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    @objc func serveScoreBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    @objc func serveFaultBtnTap(_: UIGestureRecognizer) {}

    @objc func returnAceBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    @objc func unforceErrorBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    @objc func forehandWinnersBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    @objc func backhandWinnersBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    @objc func netPointBtnTap(_ sender: UIGestureRecognizer) {
        scorePoint(view: sender.view as! TMButton)
    }

    func scorePoint(view: TMButton) {
        let pointView = view.config.relatedPointRecordView
        var serveOnLeft = pointView.config.isServingOnLeft

        if pointView.config.gameLeftNum == "6", pointView.config.gameRightNum == "6" {
            scoreTieBreakPoint(pointView: pointView)
        } else {
            if isLeft {
                switch pointView.config.pointLeftNum {
                case "0":
                    pointView.updateLeftData(at: 2, isServingOnLeft: serveOnLeft, newNum: "15")
                    pointView.config.pointLeftNum = "15"
                case "15":
                    pointView.updateLeftData(at: 2, isServingOnLeft: serveOnLeft, newNum: "30")
                    pointView.config.pointLeftNum = "30"
                case "30":
                    pointView.updateLeftData(at: 2, isServingOnLeft: serveOnLeft, newNum: "40")
                    pointView.config.pointLeftNum = "40"
                case "40":
                    if pointView.config.pointRightNum == "40" {
                        pointView.updateLeftData(at: 2, isServingOnLeft: serveOnLeft, newNum: "AD")
                        pointView.config.pointLeftNum = "AD"
                    } else if pointView.config.pointRightNum == "AD" {
                        pointView.updateRightData(at: 2, isServingOnRight: !serveOnLeft, newNum: "40")
                        pointView.config.pointRightNum = "40"
                    } else {
                        serveOnLeft.toggle()
                        pointView.config.isServingOnLeft.toggle()
                        pointView.updateLeftData(at: 2, isServingOnLeft: serveOnLeft, newNum: "0")
                        pointView.updateRightData(at: 2, isServingOnRight: !serveOnLeft, newNum: "0")
                        scoreGame(pointView: pointView)
                    }
                case "AD":
                    serveOnLeft.toggle()
                    pointView.config.isServingOnLeft.toggle()
                    pointView.updateLeftData(at: 2, isServingOnLeft: serveOnLeft, newNum: "0")
                    pointView.updateRightData(at: 2, isServingOnRight: !serveOnLeft, newNum: "0")
                    scoreGame(pointView: pointView)
                default:
                    pointView.updateLeftData(at: 3, isServingOnLeft: serveOnLeft, newNum: "0")
                    pointView.updateRightData(at: 3, isServingOnRight: !serveOnLeft, newNum: "0")
                    pointView.config.pointLeftNum = "0"
                    pointView.config.pointRightNum = "0"
                }
            } else {
                switch pointView.config.pointRightNum {
                case "0":
                    pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "15")
                    pointView.config.pointRightNum = "15"
                case "15":
                    pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "30")
                    pointView.config.pointRightNum = "30"
                case "30":
                    pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "40")
                    pointView.config.pointRightNum = "40"
                case "40":
                    if pointView.config.pointLeftNum == "40" {
                        pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "AD")
                        pointView.config.pointRightNum = "AD"
                    } else if pointView.config.pointLeftNum == "AD" {
                        pointView.updateLeftData(at: 2, isServingOnLeft: pointView.config.isServingOnLeft, newNum: "40")
                        pointView.config.pointLeftNum = "40"
                    } else {
                        serveOnLeft.toggle()
                        pointView.config.isServingOnLeft.toggle()
                        pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "0")
                        pointView.updateLeftData(at: 2, isServingOnLeft: pointView.config.isServingOnLeft, newNum: "0")
                        scoreGame(pointView: pointView)
                    }
                case "AD":
                    serveOnLeft.toggle()
                    pointView.config.isServingOnLeft.toggle()
                    pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "0")
                    pointView.updateLeftData(at: 2, isServingOnLeft: pointView.config.isServingOnLeft, newNum: "0")
                    scoreGame(pointView: pointView)
                default:
                    pointView.updateRightData(at: 2, isServingOnRight: !pointView.config.isServingOnLeft, newNum: "0")
                    pointView.updateLeftData(at: 2, isServingOnLeft: pointView.config.isServingOnLeft, newNum: "0")
                    pointView.config.pointLeftNum = "0"
                    pointView.config.pointRightNum = "0"
                }
            }
        }
    }

    func scoreTieBreakPoint(pointView: TMPointRecordView) {
        if isLeft {
            switch pointView.config.pointLeftNum {
            case "0":
                pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "1")
                pointView.config.pointLeftNum = "1"
            case "1":
                pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "2")
                pointView.config.pointLeftNum = "2"
            case "2":
                pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "3")
                pointView.config.pointLeftNum = "3"
            case "3":
                pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "4")
                pointView.config.pointLeftNum = "4"
            case "4":
                pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "5")
                pointView.config.pointLeftNum = "5"
            case "5":
                pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "6")
                pointView.config.pointLeftNum = "6"
            default:
                if Int(pointView.config.pointLeftNum)! - Int(pointView.config.pointRightNum)! < 1 {
                    pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "\(Int(pointView.config.pointLeftNum)! + 1)")
                    pointView.config.pointLeftNum = "\(Int(pointView.config.pointLeftNum)! + 1)"
                } else {
                    pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "0")
                    pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "0")
                    scoreGame(pointView: pointView)
                }
            }
        } else {
            switch pointView.config.pointRightNum {
            case "0":
                pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "1")
                pointView.config.pointRightNum = "1"
            case "1":
                pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "2")
                pointView.config.pointRightNum = "2"
            case "2":
                pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "3")
                pointView.config.pointRightNum = "3"
            case "3":
                pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "4")
                pointView.config.pointRightNum = "4"
            case "4":
                pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "5")
                pointView.config.pointRightNum = "5"
            case "5":
                pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "6")
                pointView.config.pointRightNum = "6"
            default:
                if Int(pointView.config.pointRightNum)! - Int(pointView.config.pointLeftNum)! < 1 {
                    pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "\(Int(pointView.config.pointRightNum)! + 1)")
                    pointView.config.pointRightNum = "\(Int(pointView.config.pointRightNum)! + 1)"
                } else {
                    pointView.updateRightData(at: 2, isServingOnRight: false, newNum: "0")
                    pointView.updateLeftData(at: 2, isServingOnLeft: false, newNum: "0")
                    scoreGame(pointView: pointView)
                }
            }
        }
    }

    func scoreGame(pointView: TMPointRecordView) {
        if isLeft {
            switch pointView.config.gameLeftNum {
            case "0":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "1")
                pointView.config.gameLeftNum = "1"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "1":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "2")
                pointView.config.gameLeftNum = "2"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "2":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "3")
                pointView.config.gameLeftNum = "3"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "3":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "4")
                pointView.config.gameLeftNum = "4"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "4":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "5")
                pointView.config.gameLeftNum = "5"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "5":
                if pointView.config.gameRightNum == "5" || pointView.config.gameRightNum == "6" {
                    pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "6")
                    pointView.config.gameLeftNum = "6"
                    pointView.config.pointLeftNum = "0"
                    pointView.config.pointRightNum = "0"
                } else {
                    pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "0")
                    pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "0")
                    scoreSet(pointView: pointView)
                }
            case "6":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "0")
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "0")
                scoreSet(pointView: pointView)
            default:
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "0")
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            }
        } else {
            switch pointView.config.gameRightNum {
            case "0":
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "1")
                pointView.config.gameRightNum = "1"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "1":
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "2")
                pointView.config.gameRightNum = "2"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "2":
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "3")
                pointView.config.gameRightNum = "3"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "3":
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "4")
                pointView.config.gameRightNum = "4"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "4":
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "5")
                pointView.config.gameRightNum = "5"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "5":
                if pointView.config.gameLeftNum == "5" || pointView.config.gameLeftNum == "6" {
                    pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "6")
                    pointView.config.gameRightNum = "6"
                    pointView.config.pointLeftNum = "0"
                    pointView.config.pointRightNum = "0"
                } else {
                    pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "0")
                    pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "0")
                    scoreSet(pointView: pointView)
                }
            case "6":
                pointView.updateLeftData(at: 1, isServingOnLeft: false, newNum: "0")
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "0")
                scoreSet(pointView: pointView)
            default:
                pointView.updateRightData(at: 1, isServingOnRight: false, newNum: "0")
                pointView.config.gameRightNum = "0"
            }
        }
    }

    func scoreSet(pointView: TMPointRecordView) {
        if isLeft {
            switch pointView.config.setLeftNum {
            case "0":
                pointView.updateLeftData(at: 0, isServingOnLeft: false, newNum: "1")
                pointView.config.setLeftNum = "1"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "1":
                pointView.updateLeftData(at: 0, isServingOnLeft: false, newNum: "2")
                pointView.config.setLeftNum = "2"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "2":
                pointView.updateLeftData(at: 0, isServingOnLeft: false, newNum: "3")
                pointView.config.setLeftNum = "3"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: relatedInfoView.config.name)
            default:
                pointView.updateLeftData(at: 0, isServingOnLeft: false, newNum: "0")
                pointView.config.setLeftNum = "0"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            }
        } else {
            switch pointView.config.setRightNum {
            case "0":
                pointView.updateRightData(at: 0, isServingOnRight: false, newNum: "1")
                pointView.config.setRightNum = "1"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "1":
                pointView.updateRightData(at: 0, isServingOnRight: false, newNum: "2")
                pointView.config.setRightNum = "2"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            case "2":
                pointView.updateRightData(at: 0, isServingOnRight: false, newNum: "3")
                pointView.config.setRightNum = "3"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
                NotificationCenter.default.post(name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: relatedInfoView.config.name)
            default:
                pointView.updateRightData(at: 0, isServingOnRight: false, newNum: "0")
                pointView.config.setRightNum = "0"
                pointView.config.gameLeftNum = "0"
                pointView.config.gameRightNum = "0"
                pointView.config.pointLeftNum = "0"
                pointView.config.pointRightNum = "0"
            }
        }
    }
}
