//
//  scoreControllerView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/23.
//

import Foundation
import UIKit

class scoreControllerView: UIView {
    var isLeft: Bool = true
    var relatedView = TMPointRecordView()

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

    lazy var unforceErrorBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var winnersBtn: TMButton = {
        let button = TMButton()
        return button
    }()

    lazy var netPointBtn: UIButton = {
        let button = UIButton()
        button.setTitle("NET POINT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(named: "TennisBlur"), for: .selected)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .white
        button.setCorner(radii: 15)
        return button
    }()

    func setupUI(isLeft: Bool) {
        self.isLeft = isLeft

        addSubview(aceBtn)
        addSubview(serveScoreBtn)
        addSubview(serveFaultBtn)
        addSubview(returnAceBtn)
        addSubview(unforceErrorBtn)
        addSubview(winnersBtn)
        addSubview(netPointBtn)

        let aceBtnConfig = TMButtonConfig(title: "ACE", action: #selector(aceBtnTap), actionTarget: self, relatedView: relatedView)
        let serveScoreBtnConfig = TMButtonConfig(title: "SERVE WINNER", action: #selector(serveScoreBtnTap(_:)), actionTarget: self, relatedView: relatedView)
        let serveFaultBtnConfig = TMButtonConfig(title: "SERVE  FAULT", action: #selector(aceBtnTap), actionTarget: self, relatedView: relatedView)
        let returnAceBtnConfig = TMButtonConfig(title: "RETURN  ACE", action: #selector(aceBtnTap), actionTarget: self, relatedView: relatedView)
        let unforceErrorBtnConfig = TMButtonConfig(title: "UNFORCE ERROR", action: #selector(aceBtnTap), actionTarget: self, relatedView: relatedView)
        let winnersBtnConfig = TMButtonConfig(title: "WINNER", action: #selector(aceBtnTap), actionTarget: self, relatedView: relatedView)

        aceBtn.setUp(with: aceBtnConfig)
        serveScoreBtn.setUp(with: serveScoreBtnConfig)
        serveFaultBtn.setUp(with: serveFaultBtnConfig)
        returnAceBtn.setUp(with: returnAceBtnConfig)
        unforceErrorBtn.setUp(with: unforceErrorBtnConfig)
        winnersBtn.setUp(with: winnersBtnConfig)
        netPointBtn.addTapGesture(self, #selector(netPointBtnTap(_:)))

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
            unforceErrorBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(aceBtn.snp.left)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            winnersBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(unforceErrorBtn.snp.right).offset(10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            netPointBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.left.equalTo(winnersBtn.snp.right).offset(10)
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
            unforceErrorBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(aceBtn.snp.right)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            winnersBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(unforceErrorBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
            netPointBtn.snp.makeConstraints { make in
                make.top.equalTo(aceBtn.snp.bottom).offset(10)
                make.right.equalTo(winnersBtn.snp.left).offset(-10)
                make.width.equalTo(largeBtnWidth)
                make.height.equalTo(largeBtnHeight)
            }
        }
    }

    @objc func aceBtnTap(_ sender: TMButton) {
        let button = sender.config
        print(button)
    }

    @objc func serveScoreBtnTap(_ sender: TMButton) {
        scorePoint(view: sender.config.relatedView)
    }

    @objc func serveFaultBtnTap(_ sender: TMButton) {
        print(sender.config.relatedView)
//        scorePoint(view: sender.config.relatedView)
    }

    @objc func netPointBtnTap(_ sender: UIButton) {
        sender.setTitle("asfdasf", for: .normal)
    }

    func scorePoint(view: TMPointRecordView) {
        print(view)
        if isLeft {
            switch view.config.pointLeftNum {
            case "0":
                view.updateLeftData(at: 2, isServingOnLeft: view.config.isServingOnLeft, newNum: "15")
            case "15":
                view.updateLeftData(at: 2, isServingOnLeft: view.config.isServingOnLeft, newNum: "30")
            case "30":
                view.updateLeftData(at: 2, isServingOnLeft: view.config.isServingOnLeft, newNum: "40")
            case "40":
                if view.config.pointRightNum == "40" {
                    view.updateLeftData(at: 2, isServingOnLeft: view.config.isServingOnLeft, newNum: "AD")
                    view.updateRightData(at: 2, isServingOnRight: !view.config.isServingOnLeft, newNum: "40")
                } else if view.config.pointRightNum == "AD" {
                    view.updateLeftData(at: 2, isServingOnLeft: view.config.isServingOnLeft, newNum: "40")
                    view.updateRightData(at: 2, isServingOnRight: !view.config.isServingOnLeft, newNum: "40")
                } else {
                    view.updateLeftData(at: 2, isServingOnLeft: !view.config.isServingOnLeft, newNum: "0")
                    view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "0")
                }
            default:
                view.updateLeftData(at: 3, isServingOnLeft: view.config.isServingOnLeft, newNum: "0")
                view.updateRightData(at: 3, isServingOnRight: !view.config.isServingOnLeft, newNum: "0")
            }
        } else {
            switch view.config.pointRightNum {
            case "0":
                view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "15")
            case "15":
                view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "30")
            case "30":
                view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "40")
            case "40":
                if view.config.pointLeftNum == "40" {
                    view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "AD")
                    view.updateLeftData(at: 2, isServingOnLeft: !view.config.isServingOnLeft, newNum: "40")
                } else if view.config.pointLeftNum == "AD" {
                    view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "40")
                    view.updateLeftData(at: 2, isServingOnLeft: !view.config.isServingOnLeft, newNum: "40")
                } else {
                    view.updateRightData(at: 2, isServingOnRight: !view.config.isServingOnLeft, newNum: "0")
                    view.updateLeftData(at: 2, isServingOnLeft: view.config.isServingOnLeft, newNum: "0")
                }
            default:
                view.updateRightData(at: 2, isServingOnRight: view.config.isServingOnLeft, newNum: "0")
                view.updateLeftData(at: 2, isServingOnLeft: !view.config.isServingOnLeft, newNum: "0")
            }
        }
    }
}
