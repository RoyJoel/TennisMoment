//
//  GameConfigToast.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import TMComponent
import UIKit

class TMGameConfigView: TMUserInteractionUnabledView {
    var isPlayer1Serving: Bool = true

    lazy var player1TextField: TMTextField = {
        let textField = TMTextField()
        return textField
    }()

    lazy var player2TextField: TMTextField = {
        let textField = TMTextField()
        return textField
    }()

    lazy var leftServerView: TMServerView = {
        let serveView = TMServerView()
        return serveView
    }()

    lazy var rightServerView: TMServerView = {
        let serveView = TMServerView()
        return serveView
    }()

    lazy var isGoldenGoalLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var isGoldenGoalConfigView: UISwitch = {
        let textField = UISwitch()
        return textField
    }()

    lazy var setConfigView: TMTextField = {
        let textField = TMTextField()
        return textField
    }()

    lazy var gameConfigView: TMTextField = {
        let textField = TMTextField()
        return textField
    }()

    lazy var surfaceConfigView: TMTextField = {
        let textField = TMTextField()
        return textField
    }()

    func setupUI() {
        backgroundColor = UIColor(named: "TennisBlur")
        setCorner(radii: 15)
        clipsToBounds = false

        addSubview(player1TextField)
        addSubview(player2TextField)
        addSubview(leftServerView)
        addSubview(rightServerView)
        addSubview(isGoldenGoalLabel)
        addSubview(isGoldenGoalConfigView)
        addSubview(setConfigView)
        addSubview(gameConfigView)
        addSubview(surfaceConfigView)

        player1TextField.isHidden = true
        player2TextField.isHidden = true
        leftServerView.isHidden = true
        rightServerView.isHidden = true
        isGoldenGoalLabel.isHidden = true
        isGoldenGoalConfigView.isHidden = true
        setConfigView.isHidden = true
        gameConfigView.isHidden = true
        surfaceConfigView.isHidden = true

        let player1TextFieldconfig = TMTextFieldConfig(placeholderText: "Leftside player name")
        let player2TextFieldconfig = TMTextFieldConfig(placeholderText: "Rightside player name")
        let setTextFieldConfig = TMTextFieldConfig(placeholderText: "Set number")
        let gameTextFieldConfig = TMTextFieldConfig(placeholderText: "Game number")
        let surfaceTextFieldConfig = TMTextFieldConfig(placeholderText: "Surface Type")

        player1TextField.setup(with: player1TextFieldconfig)
        player2TextField.setup(with: player2TextFieldconfig)
        leftServerView.setup(isServing: isPlayer1Serving)
        rightServerView.setup(isServing: !isPlayer1Serving)
        isGoldenGoalLabel.text = "GoldenGoal"
        isGoldenGoalLabel.textAlignment = .center
        setConfigView.setup(with: setTextFieldConfig)
        gameConfigView.setup(with: gameTextFieldConfig)
        surfaceConfigView.setup(with: surfaceTextFieldConfig)

        leftServerView.addTapGesture(self, #selector(changeServe))
        rightServerView.addTapGesture(self, #selector(changeServe))
    }

    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
        if isEnlarge {
            player1TextField.isHidden = true
            player2TextField.isHidden = true
            leftServerView.isHidden = true
            rightServerView.isHidden = true
            isGoldenGoalLabel.isHidden = true
            isGoldenGoalConfigView.isHidden = true
            setConfigView.isHidden = true
            gameConfigView.isHidden = true
            surfaceConfigView.isHidden = true
        } else {
            player1TextField.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(220)
                make.top.equalToSuperview().offset(124)
                make.height.equalTo(50)
            }

            player2TextField.snp.makeConstraints { make in
                make.left.equalTo(player1TextField.snp.right).offset(6)
                make.right.equalToSuperview().offset(76)
                make.top.equalTo(player1TextField.snp.top)
                make.height.equalTo(50)
            }

            leftServerView.snp.makeConstraints { make in
                make.centerX.equalTo(player1TextField.snp.centerX)
                make.top.equalTo(player1TextField.snp.bottom).offset(12)
                make.height.equalTo(60)
            }

            rightServerView.snp.makeConstraints { make in
                make.centerX.equalTo(player2TextField.snp.centerX)
                make.top.equalTo(leftServerView.snp.top)
                make.height.equalTo(60)
            }

            isGoldenGoalLabel.snp.makeConstraints { make in
                make.left.equalTo(leftServerView.snp.right)
                make.right.equalTo(rightServerView.snp.left)
                make.top.equalTo(player1TextField.snp.bottom).offset(12)
            }

            isGoldenGoalConfigView.snp.makeConstraints { make in
                make.centerX.equalTo(isGoldenGoalLabel.snp.centerX)
                make.top.equalTo(isGoldenGoalLabel.snp.bottom).offset(8)
            }

            setConfigView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(124)
                make.top.equalTo(leftServerView.snp.bottom).offset(22)
                make.height.equalTo(50)
            }

            gameConfigView.snp.makeConstraints { make in
                make.left.equalTo(setConfigView.snp.right).offset(24)
                make.top.equalTo(setConfigView.snp.top)
                make.height.equalTo(50)
            }

            surfaceConfigView.snp.makeConstraints { make in
                make.left.equalTo(gameConfigView.snp.right).offset(24)
                make.right.equalToSuperview().offset(76)
                make.top.equalTo(setConfigView.snp.top)
                make.height.equalTo(50)
            }

            player1TextField.isHidden = false
            player2TextField.isHidden = false
            leftServerView.isHidden = false
            rightServerView.isHidden = false
            isGoldenGoalLabel.isHidden = false
            isGoldenGoalConfigView.isHidden = false
            setConfigView.isHidden = false
            gameConfigView.isHidden = false
            surfaceConfigView.isHidden = false
        }
    }

    /// 返回用户填写的比赛数据
    /// - Returns: 0：player1LoginName，1: player2LoginName，2：setNum，3: gameNum， 4: isGoldenGoal
    func getData() -> (player1LoginName: String, player2LoginName: String, setNum: Int, gameNum: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool) {
        let player1LoginName = player1TextField.textField.text ?? ""
        let player2LoginName = player1TextField.textField.text ?? ""
        let setNum = setConfigView.textField.text ?? "0"
        let gameNum = gameConfigView.textField.text ?? "0"
        let isGoldenGoal = isGoldenGoalConfigView.isOn
        let isPlayer1Serving = isPlayer1Serving
        return (player1LoginName, player2LoginName, Int(setNum)!, Int(gameNum)!, isGoldenGoal, isPlayer1Serving)
    }

    @objc func changeServe() {
        isPlayer1Serving.toggle()
        leftServerView.changeStats(to: isPlayer1Serving)
        rightServerView.changeStats(to: !isPlayer1Serving)
    }
}
