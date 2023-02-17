//
//  TMButton.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/17.
//

import Foundation
import UIKit

class TMButton: UIButton {
    
    func setUp(with config: TMButtonConfig) {
        setupUI()
        setupEvent(config: config)
    }

    func setupUI() {
        self.setCorner(radii: 20)
        self.drawBorder(color: .black, width: 2)
    }
    func setupEvent(config: TMButtonConfig) {
        self.setTitle(config.title, for: .normal)
        self.addTapGesture(config.actionTarget, config.action)
    }
    
}
