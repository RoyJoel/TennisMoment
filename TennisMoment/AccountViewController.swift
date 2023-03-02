//
//  AccountViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Foundation
import TMComponent
import UIKit

class AccountViewController: UIViewController {
    lazy var aview: TMRecordView = {
        let view = TMRecordView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        aview.frame = CGRect(x: 100, y: 100, width: 300, height: 200)
        view.addSubview(aview)
    }
}
