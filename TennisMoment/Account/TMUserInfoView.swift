//
//  TMUserInfoView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/10.
//

import Foundation
import TMComponent
import UIKit

class TMUserInfoView: TMView {
    lazy var yearsPlayedView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var heightView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var widthView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var gripView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var backhandView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    lazy var pointsView: TMInfoView = {
        let infoView = TMInfoView()
        return infoView
    }()

    func setupUI() {
        setCorner(radii: 20)

        addSubview(yearsPlayedView)
        addSubview(heightView)
        addSubview(widthView)
        addSubview(gripView)
        addSubview(backhandView)
        addSubview(pointsView)

        yearsPlayedView.backgroundColor = .white
        heightView.backgroundColor = .white
        widthView.backgroundColor = .white
        gripView.backgroundColor = .white
        backhandView.backgroundColor = .white
        pointsView.backgroundColor = .white

        yearsPlayedView.setCorner(radii: 15)
        heightView.setCorner(radii: 15)
        widthView.setCorner(radii: 15)
        gripView.setCorner(radii: 15)
        backhandView.setCorner(radii: 15)
        pointsView.setCorner(radii: 15)

        yearsPlayedView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.left.equalToSuperview().offset(42)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        heightView.snp.makeConstraints { make in
            make.top.equalTo(yearsPlayedView.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        widthView.snp.makeConstraints { make in
            make.top.equalTo(yearsPlayedView.snp.top)
            make.right.equalToSuperview().offset(-42)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        gripView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-42)
            make.left.equalTo(yearsPlayedView.snp.left)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        backhandView.snp.makeConstraints { make in
            make.bottom.equalTo(gripView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(100)
        }

        pointsView.snp.makeConstraints { make in
            make.bottom.equalTo(gripView.snp.bottom)
            make.right.equalTo(widthView.snp.right)
            make.width.equalTo(170)
            make.height.equalTo(100)
        }
    }

    func setupEvent() {
        let yearPlayedConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.yearsPlayed)", infoContentFont: 20, infoTitle: "YearsPlayed", infoTitleFont: 17, inset: 24)
        let heightConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.height)", infoContentFont: 20, infoTitle: "Height", infoTitleFont: 17, inset: 24)
        let widthConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.width)", infoContentFont: 20, infoTitle: "Width", infoTitleFont: 17, inset: 24)
        let gripConfig = TMInfoViewConfig(infoContent: TMUser.user.grip.rawValue, infoContentFont: 20, infoTitle: "Grip", infoTitleFont: 17, inset: 24)
        let backhandConfig = TMInfoViewConfig(infoContent: TMUser.user.backhand.rawValue, infoContentFont: 17, infoTitle: "Backhand", infoTitleFont: 17, inset: 24)
        let pointsConfig = TMInfoViewConfig(infoContent: "\(TMUser.user.points)", infoContentFont: 20, infoTitle: "Current Points", infoTitleFont: 17, inset: 24)

        yearsPlayedView.setup(with: yearPlayedConfig)
        heightView.setup(with: heightConfig)
        widthView.setup(with: widthConfig)
        gripView.setup(with: gripConfig)
        backhandView.setup(with: backhandConfig)
        pointsView.setup(with: pointsConfig)
    }
}
