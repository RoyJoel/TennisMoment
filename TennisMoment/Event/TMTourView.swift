//
//  TMTourView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/15.
//

import Foundation
import TMComponent

class TMTourView: TMView {
    lazy var tourNameView: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var DateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var joinBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()

    lazy var drawView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var scheduleView: UIView = {
        let view = UIView()
        return view
    }()
}
