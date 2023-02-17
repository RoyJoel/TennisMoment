//
//  TMVSView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

class TMVSView: TMView {
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
    
    
    func setUp(with config: TMVSViewConfig) {
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
        leftPointView.setUp(with: config.leftConfig)
        rightPointView.setUp(with: config.rightConfig)
        
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
                    make.top.equalTo(titleView.snp.bottom).offset(8)
                }
                rightPointView.snp.remakeConstraints { make in
                    make.right.equalToSuperview()
                    make.top.equalTo(titleView.snp.bottom).offset(8)
                }
            }else {
                titleView.snp.remakeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.centerX.equalToSuperview()
                }
            }
        }else {
            titleView.isHidden = true
        }
    }
}
