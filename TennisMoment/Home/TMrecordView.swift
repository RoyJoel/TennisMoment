//
//  TMrecordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import TMComponent
import UIKit

class TMRecordView: TMUserInteractionUnabledView {
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
    lazy var leftScoreControllerView: scoreControllerView = {
        var button = scoreControllerView()
        return button
    }()

    /// 右侧球员记分器
    lazy var rightScoreControllerView: scoreControllerView = {
        var button = scoreControllerView()
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

        leftBasicInfoView.frame = CGRect(x: 12, y: 27, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        rightBasicInfoView.frame = CGRect(x: bounds.width - leftBasicInfoView.bounds.width - 12, y: 27, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        recordPointView.frame = CGRect(x: 24 + UIStandard.shared.screenWidth * 0.12, y: 27 + ((UIStandard.shared.screenHeight * 0.24 - 190) / 2), width: UIStandard.shared.screenWidth * 0.12, height: 190)

        let leftInfoConfig = TMInfoViewConfig(iconName: "Jason Zhang", name: "Jason Zhang")
        let rightInfoConfig = TMInfoViewConfig(iconName: "Nick Kyrgios", name: "Nick Kyrgios")
        let pointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 50, rowSpacing: 20, font: UIFont.systemFont(ofSize: 17), isTitleHidden: true, isServingOnLeft: true, setLeftNum: "0", setRightNum: "0", gameLeftNum: "0", gameRightNum: "0", pointLeftNum: "0", pointRightNum: "0")

        leftBasicInfoView.setup(with: leftInfoConfig)
        rightBasicInfoView.setup(with: rightInfoConfig)
        recordPointView.setup(with: pointRecordViewConfig)
    }

    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
        if isEnlarge {
            leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
            rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
            recordPointView.scaleTo(recordPointView.toggle)

            recordPointView.scaleTo(newRowHeight: 50, newRowSpacing: 20, newFont: UIFont.systemFont(ofSize: 17), isTitleHidden: true)

            leftScoreControllerView.isHidden = true
            rightScoreControllerView.isHidden = true
        } else {
            leftBasicInfoView.setup(leftBasicInfoView.bounds, leftBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: 24 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
            rightBasicInfoView.setup(rightBasicInfoView.bounds, rightBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: UIStandard.shared.screenWidth - 24 - UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
            recordPointView.setup(recordPointView.bounds, recordPointView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.4, height: UIStandard.shared.screenWidth * 0.25), CGPoint(x: UIStandard.shared.screenWidth * 0.5, y: 104 + UIStandard.shared.screenHeight * 0.15), 0.3)

            leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
            rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
            recordPointView.scaleTo(recordPointView.toggle)

            recordPointView.scaleTo(newRowHeight: 70, newRowSpacing: 40, newFont: UIFont.systemFont(ofSize: 24), isTitleHidden: false)

            leftScoreControllerView.setupUI(isLeft: true, relatedPointRecordView: recordPointView, relatedInfoView: leftBasicInfoView)
            rightScoreControllerView.setupUI(isLeft: false, relatedPointRecordView: recordPointView, relatedInfoView: rightBasicInfoView)

            leftScoreControllerView.frame = CGRect(x: 40, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)
            rightScoreControllerView.frame = CGRect(x: UIStandard.shared.screenWidth - 40 - UIStandard.shared.screenHeight * 0.46, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)

            leftScoreControllerView.isHidden = false
            rightScoreControllerView.isHidden = false
        }
    }
}
