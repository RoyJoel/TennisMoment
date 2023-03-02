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
    static func searchPlayer(loginName: String, completionHandler: @escaping (Player) -> Void) {
        TMNetWork.post("/player/search", dataParameters: [
            "loginName": loginName,
        ]) { data, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard data != nil else {
                return
            }
            completionHandler(Player(json: data!))
        }
    }

    static func updatePlayerInfo(player: Player) {
        TMNetWork.post("/player/update", dataParameters: [
            "id": player.id,
            "loginName": player.loginName,
            "name": player.name,
            "icon": player.icon,
            "sex": player.sex,
            "age": player.age,
            "yearsPlayed": player.yearsPlayed,
            "height": player.height,
            "width": player.width,
            "grip": player.grip,
            "backhand": player.backhand,
            "careerStats": player.careerStats,
            "friends": player.friends,
            "gamesPlayed": player.gamesPlayed,
        ]) { data, error in
            guard error == nil else {
                print(error!)
                return
            }
            UserDefault.user = Player(json: data ?? JSON())
        }
    }

    static func addGame(data: Date, place: String, user: Player, userStats: Stats, opponent: Player, opponentStats: Stats) {
        TMNetWork.post("/game/add", dataParameters: [
            "data": data,
            "place": place,
            "user": user,
            "userStats": userStats,
            "opponent": opponent,
            "opponentStats": opponentStats,
        ], completionHandler: { _, _ in })
    }
}
