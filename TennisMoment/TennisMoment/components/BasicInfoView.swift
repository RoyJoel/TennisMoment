//
//  BasinessComponent.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/27.
//

import Foundation
import SnapKit
import UIKit

class TMInfoView: TMView {
    
    private lazy var iconImage: UIImageView = {
        var image = UIImageView()
        image.setCorner(radii: 15)
        image.drawBorder(color: .white, width: 5)
        return image
    }()

    private lazy var nameView: UILabel = {
        var view = UILabel()
        return view
    }()
    
    func setup(with config: TMInfoViewConfig) {
        setupUI()
        setupEvent(config: config)
    }

    private func setupUI() {
        clipsToBounds = false
        backgroundColor = .clear
        setCorner(radii: 15)
        addSubview(iconImage)
        addSubview(nameView)

        nameView.isHidden = false

        iconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalTo(nameView.snp.top).offset(-8)
        }
        nameView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.top.equalTo(iconImage.snp.bottom).offset(8)
            make.centerX.equalTo(self.iconImage.snp.centerX)
        }
    }

    private func setupEvent(config: TMInfoViewConfig) {
        if config.iconName == nil {
            iconImage.image = UIImage(systemName: "person")
        } else {
            iconImage.image = UIImage(named: config.iconName ?? "person")
            iconImage.contentMode = .scaleAspectFill
        }
        if config.name == "" {
            nameView.isHidden = true
        } else {
            nameView.isHidden = false
            nameView.text = config.name
            nameView.textColor = .blue
        }
    }
    
    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
//        UIView.animate(withDuration: 0.3) {
//            self.iconImage.snp.updateConstraints { make in
//                make.centerX.equalToSuperview()
//                make.left.equalToSuperview().offset(8)
//                make.right.equalToSuperview().offset(-8)
//                make.width.equalToSuperview().offset(-16)
//                make.height.equalToSuperview().offset(-16)
//                make.top.equalToSuperview().offset(8)
//                make.bottom.equalTo(self.nameView.snp.top).offset(-8)
//            }
//            self.nameView.snp.updateConstraints { make in
//                make.bottom.equalToSuperview().offset(-8)
//                make.top.equalTo(self.iconImage.snp.bottom).offset(8)
//                make.centerX.equalTo(self.iconImage.snp.centerX)
//            }
//        }
//        addGroupAnimation(with: [iconImage,nameView], isEnlarge: isEnlarge)
    }

//    override func didScaleTo(_ isEnlarge: Bool) {
//        super.didScaleTo(isEnlarge)
//        print(iconImage.layer.position)
//        print(iconImage.layer.bounds)
////        iconImage.scaleTo(isEnlarge)
////        nameView.scaleTo(isEnlarge)
//    }
}
