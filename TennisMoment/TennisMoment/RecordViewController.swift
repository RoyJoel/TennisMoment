//
//  RecordViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import UIKit
import TMComponent

class RecordViewController: UIViewController {
    var isRecordViewFullScreen = false
    var homeViewAttributeTitle: NSMutableAttributedString = .init(string: "Home")

    lazy var titleView: UILabel = {
        var label = UILabel()
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSMakeRange(0, 4))
        label.attributedText = homeViewAttributeTitle
        return label
    }()

    lazy var recordView: TMUserInteractionUnabledView = {
        var view = TMUserInteractionUnabledView()
        view.backgroundColor = .green
        view.setCorner(radii: 15)
        return view
    }()

//    lazy var leftBasicInfoView: TMInfoView = {
//        var view = TMInfoView()
//        return view
//    }()
//
//    lazy var rightBasicInfoView: TMInfoView = {
//        var view = TMInfoView()
//        return view
//    }()
//
//    lazy var leftPointUpButton: TMButton = {
//        var button = TMButton()
//        return button
//    }()
    
    lazy var pointRecordView: TMPointRecordView = {
        var label = TMPointRecordView()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.titleView = titleView
        navigationItem.hidesBackButton = true
        

        view.addSubview(recordView)

        recordView.frame = CGRect(x: 12, y: 72, width: UIStandard.shared.screenWidth * 0.4, height: UIStandard.shared.screenHeight * 0.3)
        recordView.addTapGesture(self, #selector(jump))
        
//        let leftInfoConfig = TMInfoViewConfig(iconName:"Jason Zhang", name: "Jason Zhang")
//        let rightInfoConfig = TMInfoViewConfig(iconName: "Nick Kyrgios", name: "Nick Kyrgios")
//        let leftButtonConfig = TMButtonConfig(title: "得一分", action: #selector(backToHome), actionTarget: self)
        
        let leftConfig = TMBasicPointViewConfig(isLeft: true, font: UIFont(), num: 0)
        let rightConfig = TMBasicPointViewConfig(isLeft: false, font: UIFont(), num: 0)
        let setConfig = TMVSViewConfig(isTitleViewAbovePointView: true, title: "SET", leftConfig: leftConfig, rightConfig: rightConfig)
        let gameConfig = TMVSViewConfig(isTitleViewAbovePointView: true, title: "GAME", leftConfig: leftConfig, rightConfig: rightConfig)
        let pointConfig = TMVSViewConfig(isTitleViewAbovePointView: true, title: "POINT", leftConfig: leftConfig, rightConfig: rightConfig)
        let pointRecordViewConfig = TMPointRecordViewConfig(rowHeight: 60, setViewConfig: setConfig, gameViewConfig: gameConfig, pointViewConfig: pointConfig)
        
        pointRecordView.setup(with: pointRecordViewConfig)
//        leftBasicInfoView.setup(with: leftInfoConfig)
//        rightBasicInfoView.setup(with: rightInfoConfig)
//        leftPointUpButton.setUp(with: leftButtonConfig)
        
//        recordView.addSubview(leftBasicInfoView)
//        recordView.addSubview(rightBasicInfoView)
        recordView.addSubview(pointRecordView)
//        recordView.addSubview(leftPointUpButton)
        
        
        
//        leftPointUpButton.isHidden = true
//
//        leftBasicInfoView.frame = CGRect(x: 12, y: 27, width: UIStandard.shared.screenWidth *  0.12, height: UIStandard.shared.screenHeight * 0.24)
//        rightBasicInfoView.frame = CGRect(x: recordView.bounds.width - leftBasicInfoView.bounds.width - 12, y: 27, width: UIStandard.shared.screenWidth *  0.12, height: UIStandard.shared.screenHeight * 0.24)
        pointRecordView.frame = CGRect(x: 24 + UIStandard.shared.screenWidth *  0.12, y: 27 + ((UIStandard.shared.screenHeight * 0.24 - 163) / 2), width: UIStandard.shared.screenWidth *  0.12, height: 180)
       
    }

    @objc private func jump() {
        titleView.text = "Record"
        
        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)
//        leftBasicInfoView.setup(leftBasicInfoView.bounds, leftBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: 24 + UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
//        rightBasicInfoView.setup(rightBasicInfoView.bounds, rightBasicInfoView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.3, height: UIStandard.shared.screenWidth * 0.3), CGPoint(x: UIStandard.shared.screenWidth - 24 - UIStandard.shared.screenWidth * 0.15, y: 124 + UIStandard.shared.screenHeight * 0.15), 0.3)
        pointRecordView.setup(pointRecordView.bounds, pointRecordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenHeight * 0.4, height: UIStandard.shared.screenWidth * 0.25), CGPoint(x: UIStandard.shared.screenWidth * 0.5, y: 104 + UIStandard.shared.screenHeight * 0.15), 0.3)
        
        recordView.scaleTo(recordView.toggle)
//        leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
//        rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
        pointRecordView.scaleTo(pointRecordView.toggle)
//        leftPointUpButton.frame = CGRect(x: 36, y: 124 + leftBasicInfoView.bounds.height, width: 80, height: 50)
//        leftPointUpButton.isHidden = false
        
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backToHome)), animated: true)
        
    }
    
    @objc private func backToHome() {
        titleView.text = "Home"
        recordView.scaleTo(recordView.toggle)
//        leftBasicInfoView.scaleTo(leftBasicInfoView.toggle)
//        rightBasicInfoView.scaleTo(rightBasicInfoView.toggle)
        pointRecordView.scaleTo(pointRecordView.toggle)
        navigationItem.leftBarButtonItem = nil
        
//        leftPointUpButton.isHidden = true
        
    }
}
