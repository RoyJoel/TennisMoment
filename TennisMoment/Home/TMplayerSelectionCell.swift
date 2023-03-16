//
//  TMplayerSelectionCell.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/16.
//

import Foundation
import UIKit

class TMplayerSelectionCell: TMPopUpViewCell {
    lazy var playerIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var playerNameView: UILabel = {
        let label = UILabel()
        return label
    }()

    func setup() {
        addSubview(playerIconView)
        addSubview(playerNameView)

        playerIconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        playerNameView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(playerIconView.snp.right).offset(6)
        }
    }

    func setupEvent(imageName: String, playerName: String) {
        playerIconView.image = UIImage(systemName: imageName)
        playerNameView.text = playerName
    }
}
