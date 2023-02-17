//
//  TMBasicPointView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

class TMBasicPointView: TMView {
    private lazy var highLightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Jason Zhang")
        imageView.setCorner(radii: 10)
        return imageView
    }()
    
    private lazy var pointLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setUp(with config: TMBasicPointViewConfig) {
        setupUI()
        setupEvent(config: config)
    }
    
    func setupUI() {
        addSubview(highLightImage)
        addSubview(pointLabel)
        highLightImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        pointLabel.snp.makeConstraints { make in
            make.left.equalTo(highLightImage.snp.right).offset(8)
        }
    }
    func setupEvent(config: TMBasicPointViewConfig) {
        if !config.isLeft {
            highLightImage.snp.remakeConstraints { make in
                make.right.equalToSuperview()
                make.width.equalTo(20)
                make.height.equalTo(20)
            }
            pointLabel.snp.remakeConstraints { make in
                make.right.equalTo(highLightImage.snp.left).offset(-8)
            }
        }
        pointLabel.text = "\(config.num)"
        pointLabel.font = config.font
    }
}
