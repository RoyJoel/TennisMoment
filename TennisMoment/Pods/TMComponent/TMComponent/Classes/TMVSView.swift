//
//  TMVSView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

/// 双方得分视图，使用时仅需设置宽度
open class TMVSView: TMView {
    private lazy var titleView: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var leftPointView: TMBasicPointView = {
        let pointView = TMBasicPointView()
        return pointView
    }()

    private lazy var rightPointView: TMBasicPointView = {
        let pointView = TMBasicPointView()
        return pointView
    }()

    func setup(with config: TMVSViewConfig) {
        setupUI()
        setupEvent(config: config)
    }

    func setupUI() {
        addSubview(titleView)
        addSubview(leftPointView)
        addSubview(rightPointView)

        leftPointView.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        rightPointView.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }

        titleView.isHidden = true
    }

    func setupEvent(config: TMVSViewConfig) {
        leftPointView.setup(with: config.leftConfig)
        rightPointView.setup(with: config.rightConfig)

        if config.title != nil {
            titleView.text = config.title
            titleView.isHidden = false
            if config.isTitleViewAbovePointView {
                titleView.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.centerX.equalToSuperview()
                }
                leftPointView.snp.remakeConstraints { make in
                    make.left.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
                rightPointView.snp.remakeConstraints { make in
                    make.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            } else {
                titleView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                leftPointView.snp.remakeConstraints { make in
                    make.left.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                rightPointView.snp.remakeConstraints { make in
                    make.right.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            }
        } else {
            titleView.isHidden = true
        }
    }
}
