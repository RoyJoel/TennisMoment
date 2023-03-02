//
//  RecordViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Alamofire
import Foundation
import SwiftyJSON
import TMComponent
import UIKit

class RecordViewController: UIViewController {
    lazy var toastView: TMWinnerToastView = {
        let view = TMWinnerToastView()
        return view
    }()

    lazy var custonButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(custonButton)
        custonButton.setTitle("qunidaye", for: .normal)
        custonButton.backgroundColor = .green
        custonButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        custonButton.titleLabel?.textColor = .black
        custonButton.addTarget(self, action: #selector(five), for: .touchDown)
    }

    @objc func five() {
//        let o = URL(string: "/player/getAll")
        let a = TMNetWork.get("/player/getAll") { json, _ in
            json?["data"].arrayValue.map { json in
                print(Player(json: json))
            }
        }
//        let a = AF.request(o!).response { response in
//            print(Player(json: JSON(response.data)))
//        }
//        let player = Player(id: 1, loginName: "", name: "", icon: UIImage(systemName: "person")!, sex: .Man, age: 1, yearsPlayed: 1, height: 1, width: 1, grip: .Continented, backhand: .TwoHandedBackhand, points: 1, isAdult: false, careerStats: Stats(json: JSON()), friends: [], gamesPlayed: [])
//        print(player.toJSON())
    }
}
