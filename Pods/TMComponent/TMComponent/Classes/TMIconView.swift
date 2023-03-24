//
//  BasinessComponent.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/27.
//

import Foundation
import SnapKit
import UIKit

/// 基本信息视图，使用时需设置宽高，图片大小将随之变化
open class TMIconView: TMView {
    public var config = TMIconViewConfig(icon: "", name: "")

    private lazy var iconImage: UIImageView = {
        var image = UIImageView()
        image.setCorner(radii: 15)
        return image
    }()

    private lazy var nameView: UILabel = {
        var view = UILabel()
        return view
    }()

    public func setupUI() {
        clipsToBounds = false
        addSubview(iconImage)
        addSubview(nameView)

        iconImage.contentMode = .scaleAspectFill

        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
        }
        nameView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.top.equalTo(iconImage.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.centerX.equalTo(self.iconImage.snp.centerX)
        }
    }

    public func setupEvent(config: TMIconViewConfig) {
        self.config = config
        iconImage.image = UIImage(named: config.icon)
        nameView.text = config.name
    }

    public func updateInfo(with icon: String, named name: String) {
        config.icon = icon
        config.name = name
        iconImage.image = UIImage(named: config.icon)
        nameView.text = config.name
    }
}
