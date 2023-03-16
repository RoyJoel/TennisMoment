//
//  serverView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation
import TMComponent

class TMServerView: TMView {
    lazy var selectionView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    func setup(isServing: Bool) {
        addSubview(selectionView)
        addSubview(textLabel)

        selectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        textLabel.snp.makeConstraints { make in
            make.top.equalTo(selectionView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }

        textLabel.textAlignment = .center
        if isServing {
            selectionView.image = UIImage(systemName: "tennisball.fill")?.withTintColor(UIColor(named: "Tennis") ?? .black, renderingMode: .alwaysOriginal)
            textLabel.text = "To serve"
        } else {
            selectionView.image = UIImage(systemName: "tennisball")?.withTintColor(UIColor(named: "Tennis") ?? .black, renderingMode: .alwaysOriginal)
            textLabel.text = "To return"
        }
    }

    func changeStats(to isSelected: Bool) {
        if isSelected {
            selectionView.image = UIImage(systemName: "tennisball.fill")?.withTintColor(UIColor(named: "Tennis") ?? .black, renderingMode: .alwaysOriginal)
            textLabel.text = "To serve"
        } else {
            selectionView.image = UIImage(systemName: "tennisball")?.withTintColor(UIColor(named: "Tennis") ?? .black, renderingMode: .alwaysOriginal)
            textLabel.text = "To return"
        }
    }
}
