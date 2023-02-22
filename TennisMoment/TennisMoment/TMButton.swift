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
        setCorner(radii: 20)
        drawBorder(color: .black, width: 2)
    }

    func setupEvent(config: TMButtonConfig) {
        setTitle(config.title, for: .normal)
        addTapGesture(config.actionTarget, config.action)
    }
}
