//
//  TMRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/28.
//

import Alamofire
import Foundation
import SwiftyJSON

class TMPlayerRequest {
    static func addPlayer(player: Player, completionHandler: @escaping (Player) -> Void) {
        let para = [
            "loginName": player.loginName,
            "name": player.name,
            "icon": player.icon,
            "sex": player.sex.rawValue,
            "age": player.age,
            "yearsPlayed": player.yearsPlayed,
            "height": player.height,
            "width": player.width,
            "grip": player.grip.rawValue,
            "backhand": player.backhand.rawValue,
            "points": player.points,
            "isAdult": player.isAdult,
            "careerStatsId": player.careerStatsId,
            "friends": player.friends,
        ] as! [String: Any]

        TMNetWork.post("/player/add", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            TMUser.user = Player(json: json)
            completionHandler(TMUser.user)
        }
    }

    static func searchPlayer(loginName: String, completionHandler: @escaping (Player?) -> Void) {
        let para = [
            "loginName": loginName,
        ]
        TMNetWork.post("/player/search", dataParameters: para) { json in
            guard let json = json else {
                completionHandler(nil)
                return
            }
            completionHandler(Player(json: json))
        }
    }

    static func updatePlayerInfo(player: Player, completionHandler: @escaping (Player) -> Void) {
        let para = [
            "loginName": player.loginName,
            "name": player.name,
            "icon": player.icon,
            "sex": player.sex.rawValue,
            "age": player.age,
            "yearsPlayed": player.yearsPlayed,
            "height": player.height,
            "width": player.width,
            "grip": player.grip.rawValue,
            "backhand": player.backhand.rawValue,
            "points": player.points,
            "isAdult": player.isAdult,
            "careerStatsId": player.careerStatsId,
            "friends": player.friends,
        ] as! [String: Any]

        TMNetWork.post("/player/update", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(Player(json: json))
        }
    }
}
