//
//  TMClubContentView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import TMComponent
import UIKit

class TMClubContentView: TMView {
    lazy var clubIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    lazy var clubNameView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var joinBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    lazy var introView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var adressView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var tourView: TMTourView = {
        let view = TMTourView()
        return view
    }()

    func setupUI() {}

    func setupEvent() {}
}
