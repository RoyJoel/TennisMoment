//
//  HomeViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import TMComponent
import Toast_Swift
import UIKit

/// 首页V1
class HomeViewController: UIViewController {
    var isRecordViewFullScreen = false
    var homeViewAttributeTitle: NSMutableAttributedString = .init(string: "")

    /// 导航栏标题
    lazy var titleView: UILabel = {
        var label = UILabel()
        label.attributedText = homeViewAttributeTitle
        return label
    }()

    /// 比赛记录视图
    lazy var recordView: TMRecordView = {
        var view = TMRecordView()
        view.backgroundColor = UIColor(named: "TennisBlur")
        view.setCorner(radii: 15)
        return view
    }()

    lazy var addGameBtn: TMTitleOrImageView = {
        let button = TMButton()
        return button
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
        view.addSubview(addGameBtn)

        recordView.frame = CGRect(x: 12, y: 72, width: UIStandard.shared.screenWidth * 0.4, height: UIStandard.shared.screenHeight * 0.3)
        addGameBtn.frame = CGRect(x: 24 + recordView.bounds.width, y: 72, width: 100, height: 100)

        recordView.setupUI()
        recordView.addTapGesture(self, #selector(jump))

//        let addGameBtnConfig = TMButtonConfig(title: " + ", action: #selector(addGame), relatedPointRecordView: <#T##TMPointRecordView#>, relatedInfoView: <#T##TMInfoView#>)

        NotificationCenter.default.addObserver(self, selector: #selector(toastUp(_:)), name: Notification.Name(ToastNotification.HomeViewToast.notificationName.rawValue), object: nil)
    }

    @objc private func jump() {
        homeViewAttributeTitle = .init(string: "Record")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backToHome)), animated: true)
        navigationItem.leftBarButtonItem?.tintColor = .black

        recordView.setup(recordView.bounds, recordView.layer.position, CGRect(x: 0, y: 0, width: UIStandard.shared.screenWidth, height: UIStandard.shared.screenHeight), CGPoint(x: UIStandard.shared.screenWidth / 2, y: UIStandard.shared.screenHeight / 2), 0.3)

        recordView.scaleTo(recordView.toggle)
    }

    @objc private func backToHome() {
        homeViewAttributeTitle = .init(string: "Home")
        homeViewAttributeTitle.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)], range: NSRange(location: 0, length: homeViewAttributeTitle.string.count))
        titleView.attributedText = homeViewAttributeTitle
        titleView.sizeToFit()

        navigationItem.leftBarButtonItem = nil

        recordView.scaleTo(recordView.toggle)
    }

    @objc func toastUp(_ obj: Notification) {
        let winner = obj.object as? String ?? ""
        let toastView = TMWinnerToastView()
        toastView.setupUI(winner)
        view.showToast(toastView, position: .center)
    }
}
