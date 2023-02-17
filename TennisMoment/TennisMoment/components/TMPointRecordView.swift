//
//  TMLabel.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

class TMPointRecordView: TMView {
    private lazy var setView: TMVSView = {
        var label = TMVSView()
        return label
    }()
    
    private lazy var gameView: TMVSView = {
        var label = TMVSView()
        return label
    }()

    private lazy var pointView: TMVSView = {
        var label = TMVSView()
        return label
    }()
    
    func setup(with config: TMPointRecordViewConfig) {
        setupUI()
        setupEvent(config: config)
    }
    
    func setupUI() {
        addSubview(setView)
        addSubview(gameView)
        addSubview(pointView)
        
        setView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(49)
            make.centerX.equalToSuperview()
        }
        gameView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(49)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        pointView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(49)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupEvent(config: TMPointRecordViewConfig) {
        setView.setUp(with: config.setViewConfig)
        gameView.setUp(with: config.gameViewConfig)
        pointView.setUp(with: config.pointViewConfig)
    }
    
    override func scaleTo(_ isEnlarge: Bool) {
        super.scaleTo(isEnlarge)
        if !isEnlarge {
            
//            setLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//            gameLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//            pointLabel.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//
//            setLabel.isHidden = false
//            gameLabel.isHidden = false
//            pointLabel.isHidden = false
            
//            setView.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//            }
//            gameView.snp.makeConstraints { make in
//                make.top.equalTo(setView.snp.bottom).offset(32)
//                make.centerX.equalToSuperview()
//            }
//            pointView.snp.makeConstraints { make in
//                make.top.equalTo(gameView.snp.bottom).offset(32)
//                make.centerX.equalToSuperview()
//            }
            
//            let setNumFont = UIFont.systemFont(ofSize: 36, weight: .semibold)
//            setNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: setNumFont)
//            let gameNumFont = UIFont.systemFont(ofSize: 32, weight: .regular)
//            gameNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: gameNumFont)
//            let pointNumFont = UIFont.systemFont(ofSize: 28, weight: .light)
//            pointNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: pointNumFont)
//
            
        }else {
            
//            setView.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//            }
//            gameView.snp.makeConstraints { make in
//                make.top.equalTo(setView.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
//            pointView.snp.makeConstraints { make in
//                make.top.equalTo(gameView.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
            
//            setLabel.isHidden = true
//            gameLabel.isHidden = true
//            pointLabel.isHidden = true
//
//            setLabel.snp.remakeConstraints { make in
//                make.top.equalToSuperview().offset(4)
//                make.centerX.equalToSuperview()
//            }
//            setNumLabel.snp.remakeConstraints { make in
//                make.top.equalTo(setLabel.snp.bottom).offset(4)
//                make.centerX.equalToSuperview()
//            }
//            gameLabel.snp.remakeConstraints { make in
//                make.top.equalTo(setNumLabel.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
//            gameNumLabel.snp.remakeConstraints { make in
//                make.top.equalTo(gameLabel.snp.bottom).offset(4)
//                make.centerX.equalToSuperview()
//            }
//            pointLabel.snp.remakeConstraints { make in
//                make.top.equalTo(gameNumLabel.snp.bottom).offset(8)
//                make.centerX.equalToSuperview()
//            }
//            pointNumLabel.snp.remakeConstraints { make in
//                make.top.equalTo(pointLabel.snp.bottom).offset(4)
//                make.centerX.equalToSuperview()
//            }
//            let font = UIFont.systemFont(ofSize: 17, weight: .light)
//            setLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            setNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            gameLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            gameNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            pointLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
//            pointNumLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: font)
        }
    }
    
}
