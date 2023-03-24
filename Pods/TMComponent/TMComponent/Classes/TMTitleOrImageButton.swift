//
//  TMTitleOrImageButton.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import UIKit

open class TMTitleOrImageButton: TMButton {
    private lazy var optionalImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var optionalTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    public func setUp(with config: TMTitleOrImageButtonConfig) {
        setupUI()
        setupEvent(config: config)
    }

    public override func setupUI() {
        super.setupUI()
        addSubview(optionalImageView)
        addSubview(optionalTitleLabel)

        optionalTitleLabel.numberOfLines = 1
        optionalTitleLabel.textAlignment = .center
        optionalTitleLabel.font = UIFont.systemFont(ofSize: 14)

        optionalImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-12)
            make.height.equalTo(30)
        }
        optionalTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-6)
            make.height.equalTo(30)
        }
        optionalImageView.isHidden = true
        optionalTitleLabel.isHidden = true
    }

    private func setupEvent(config: TMTitleOrImageButtonConfig) {
        addTapGesture(config.actionTarget, config.action)

        if let image = config.image {
            optionalImageView.isHidden = false
            optionalTitleLabel.isHidden = true

            optionalImageView.image = image

            optionalImageView.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(bounds.width * 0.6)
                make.height.equalTo(bounds.height * 0.6)
            }
        } else {
            optionalImageView.isHidden = true
            if let title = config.title {
                optionalTitleLabel.isHidden = false

                optionalTitleLabel.text = title

                optionalTitleLabel.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.width.equalTo(bounds.width * 0.6)
                    make.height.equalTo(bounds.height * 0.6)
                }
            } else {
                optionalTitleLabel.isHidden = true
            }
        }
    }
}
