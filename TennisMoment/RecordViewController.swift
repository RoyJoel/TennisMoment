//
//  RecordViewController.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/26.
//

import Alamofire
import Foundation
import MapKit
import SwiftyJSON
import TMComponent
import UIKit

class RecordViewController: UIViewController, CLLocationManagerDelegate {
//    lazy var toastView: TMGameConfigView = {
//        let view = TMGameConfigView()
//        return view
//    }()

    lazy var custonButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(custonButton)
//        view.addSubview(toastView)
//        toastView.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
//        toastView.setupUI()
//        toastView.addTapGesture(self, #selector(five))
//        toastView.isHidden = true
        custonButton.setTitle("qunidaye", for: .normal)
        custonButton.backgroundColor = .green
        custonButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        custonButton.titleLabel?.textColor = .black
        custonButton.addTarget(self, action: #selector(five), for: .touchDown)
    }

    @objc func five() {
//        TMGameRequest.searchAllGames(for: "p") { games in
//            print(games)
//        }
//        let player5 = Player(loginName: "jasony", name: "Nick Kyrgios", icon: "Nick Kyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStatsId: 1, friends: "p")
        let game3 = Game(date: Date().timeIntervalSince1970, place: "西安邮", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isPlayer1Serving: true, isCompleted: true, player1LoginName: "jason1", player1StatsId: 72, player2LoginName: "jasony", player2StatsId: 73, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[5, 3], [5, 1], [5, 0], [5, 3], [3, 5], [5, 1], [5, 1]], [[5, 1], [2, 5]]])
//        TMPlayerRequest.addPlayer(player: player5) { player in
//            print(player)
//        }
        TMGameRequest.addGame(game: game3) { result in
            print(result)
        }
//        let stats = Stats(id: 78, aces: 2, doubleFaults: 3, firstServePoints: 4, firstServePointsIn: 5, firstServePointsWon: 2, secondServePoints: 3, secondServePointsWon: 4, breakPointsFaced: 5, breakPointsSaved: 2, serveGamesPlayed: 3, serveGamesWon: 4, totalServePointsWon: 5, firstServeReturnPoints: 2, firstServeReturnAces: 3, firstServeReturnPointsWon: 4, secondServeReturnPoints: 5, secondServeReturnAces: 6, secondServeReturnPointsWon: 2, breakPointsOpportunities: 3, breakPointsConverted: 4, returnGamesPlayed: 5, returnGamesWon: 6, totalReturnPointsWon: 2, totalPointsWon: 3, netPoints: 4, unforcedErrors: 2, forehandWinners: 2, backhandWinners: 2)
//        TMStatsRequest.updateStats(stats: stats) { stats in
//            print(stats)
//
//            TMStatsRequest.searchStats(id: 78) { stats in
//                print(stats)
//            }
//        }
//        print(Date().timeIntervalSince1970)

//        let game1 = Game(date: Date().timeIntervalSince1970, place: "西安邮电大学雁塔校区", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: false, isCompleted: false, player1LoginName: "jason", player1StatsId: 0, player2LoginName: "p", player2StatsId: 1, result: [[2, 3], [3, 2]])
//        TMGameRequest.addGame(game: game1) { res in
//            print(res)
//        }
        ////        let relationship = Relationship(loginName: "p", friendLoginName: "TennisMoment")
//        let game2 = Game(date: Date().timeIntervalSince1970, place: "西安邮电大学雁塔校区", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isCompleted: true, player1LoginName: "p", player1StatsId: 0, player2LoginName: "jason", player2StatsId: 1, result: [[2, 3], [3, 2]])
//        let player1 = Player(loginName: "zhangjiacheng", name: "Jason Zhang", icon: "Jason Zhang", sex: .Man, age: 21, yearsPlayed: 1, height: 1, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStatsId: 1, friends: "p")
//        TMGameRequest.searchAllGames(for: "p") { games in
//            print(games)
//        }
//        TMGameRequest.saveGame(game: game2)

//        User.signUp(with: player5)
//        User.signUp(with: player2)
//        toastView.setup(toastView.bounds, toastView.layer.position, CGRect(x: 100, y: 100, width: UIStandard.shared.screenWidth * 0.4, height: 100), CGPoint(x: 125 + (UIStandard.shared.screenWidth * 0.4 - 50) / 2, y: 150), 0.3)
//        toastView.scaleTo(toastView.toggle)

//        let toastView = GameConfigToastView()
//        toastView.backgroundColor = .blue
//        toastView.setupUI()
//        view.showToast(toastView, position: .center)
//        let o = URL(string: "/player/getAll")
//        let a = TMNetWork.get("/player/getAll") { json, _ in
//            json?["data"].arrayValue.map { json in
//                print(Player(json: json))
//            }
//        }
//        let a = AF.request(o!).response { response in
//            print(Player(json: JSON(response.data)))
//        }
//        let player = Player(id: 1, loginName: "", name: "", icon: UIImage(systemName: "person")!, sex: .Man, age: 1, yearsPlayed: 1, height: 1, width: 1, grip: .Continented, backhand: .TwoHandedBackhand, points: 1, isAdult: false, careerStats: Stats(json: JSON()), friends: [], gamesPlayed: [])
//        print(player.toJSON())
    }
}
