//
//  HomeViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import TMComponent
import UIKit

class HomeViewController: UIViewController {
    var isRecordViewFullScreen = false
    var homeViewAttributeTitle: NSMutableAttributedString = .init(string: "")

    lazy var titleView: UILabel = {
        var label = UILabel()
        label.attributedText = homeViewAttributeTitle
        return label
    }()

    lazy var recordView: TMUserInteractionUnabledView = {
        var view = TMUserInteractionUnabledView()
        view.backgroundColor = UIColor(named: "TennisBlur")
        view.setCorner(radii: 15)
        return view
    }()

    lazy var leftBasicInfoView: TMInfoView = {
        var view = TMInfoView()
        view.isUserInteractionEnabled = false
        return view
    }()

    lazy var rightBasicInfoView: TMInfoView = {
        var view = TMInfoView()
        view.isUserInteractionEnabled = false
        return view
    }()

    lazy var leftScoreControllerView: scoreControllerView = {
        var button = scoreControllerView()
        return button
    }()

    lazy var rightScoreControllerView: scoreControllerView = {
        var button = scoreControllerView()
        return button
    }()

    lazy var recordPointView: TMPointRecordView = {
        let view = TMPointRecordView()
        view.isUserInteractionEnabled = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewAttributeTitle = .init(string: "Home")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.titleView = titleView
        navigationItem.hidesBackButton = true

        view.addSubview(recordView)
        recordView.addSubview(leftBasicInfoView)
        recordView.addSubview(rightBasicInfoView)
        recordView.addSubview(recordPointView)
        recordView.addSubview(leftScoreControllerView)
        recordView.addSubview(rightScoreControllerView)

        recordView.frame = CGRect(x: 12, y: 72, width: UIStandard.shared.screenWidth * 0.4, height: UIStandard.shared.screenHeight * 0.3)
        leftBasicInfoView.frame = CGRect(x: 12, y: 27, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        rightBasicInfoView.frame = CGRect(x: recordView.bounds.width - leftBasicInfoView.bounds.width - 12, y: 27, width: UIStandard.shared.screenWidth * 0.12, height: UIStandard.shared.screenHeight * 0.24)
        recordPointView.frame = CGRect(x: 24 + UIStandard.shared.screenWidth * 0.12, y: 27 + ((UIStandard.shared.screenHeight * 0.24 - 190) / 2), width: UIStandard.shared.screenWidth * 0.12, height: 190)

        recordView.addTapGesture(self, #selector(jump))

        let leftInfoConfig = TMInfoViewConfig(iconName: "Jason Zhang", name: "Jason Zhang")
        let rightInfoConfig = TMInfoViewConfig(iconName: "Nick Kyrgios", name: "Nick Kyrgios")
        let pointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 50, rowSpacing: 20, font: UIFont.systemFont(ofSize: 17), isTitleHidden: true, isServingOnLeft: true, setLeftNum: "0", setRightNum: "0", gameLeftNum: "0", gameRightNum: "0", pointLeftNum: "0", pointRightNum: "0")

        leftBasicInfoView.setup(with: leftInfoConfig)
        rightBasicInfoView.setup(with: rightInfoConfig)
        recordPointView.setup(with: pointRecordViewConfig)

//        leftScoreControllerView.aceBtn.addTapGesture(self.leftScoreControllerView.aceBtn, #selector(leftScoreControllerView.aceBtnTap(view: recordPointView, isLeft: true, originalServing: pointRecordViewConfig.isServingOnLeft, originalLeftNum: pointRecordViewConfig.pointLeftNum, originalRightNum: pointRecordViewConfig.pointRightNum)))
//        leftScoreControllerView.aceBtn.addTapGesture(self, #selector(backToHome))
    }

    @objc private func jump() {
        homeViewAttributeTitle = .init(string: "Record")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backToHome)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = .black

        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)
        leftBasicInfoView.setup(leftBasicInfoView.bounds, leftBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: 24 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
        rightBasicInfoView.setup(rightBasicInfoView.bounds, rightBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: UIStandard.shared.screenWidth - 24 - UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
        recordPointView.setup(recordPointView.bounds, recordPointView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.4, height: UIStandard.shared.screenWidth * 0.25), CGPoint(x: UIStandard.shared.screenWidth * 0.5, y: 104 + UIStandard.shared.screenHeight * 0.15), 0.3)

        recordView.scaleTo(recordView.toggle)
        leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
        rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
        recordPointView.scaleTo(recordPointView.toggle)

        let newPointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 70, rowSpacing: 40, font: UIFont.systemFont(ofSize: 24), isTitleHidden: false, isServingOnLeft: true, setLeftNum: "0", setRightNum: "0", gameLeftNum: "0", gameRightNum: "0", pointLeftNum: "0", pointRightNum: "0")
        recordPointView.reset(with: newPointRecordViewConfig)

        leftScoreControllerView.setupUI(isLeft: true)
        rightScoreControllerView.setupUI(isLeft: false)

        leftScoreControllerView.frame = CGRect(x: 40, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)
        rightScoreControllerView.frame = CGRect(x: UIStandard.shared.screenHeight - 40, y: 88 + leftBasicInfoView.bounds.height, width: UIStandard.shared.screenHeight * 0.46, height: UIStandard.shared.screenWidth * 0.25)

        leftScoreControllerView.isHidden = false
        rightScoreControllerView.isHidden = false
    }

    @objc private func backToHome() {
        homeViewAttributeTitle = .init(string: "Home")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.leftBarButtonItem = nil

        recordView.scaleTo(recordView.toggle)
        leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
        rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
        recordPointView.scaleTo(recordPointView.toggle)

        let newPointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 50, rowSpacing: 20, font: UIFont.systemFont(ofSize: 17), isTitleHidden: true, isServingOnLeft: true, setLeftNum: "0", setRightNum: "0", gameLeftNum: "0", gameRightNum: "0", pointLeftNum: "0", pointRightNum: "0")
        recordPointView.reset(with: newPointRecordViewConfig)

        leftScoreControllerView.isHidden = true
        rightScoreControllerView.isHidden = true
    }

    @objc func a(_ sender: scoreControllerView) {
        print(sender)
    }
}
