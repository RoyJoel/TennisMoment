//
//  User.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/28.
//

import Alamofire
import Foundation
import SwiftyJSON
import UIKit

class UserDefault {
    // 未登录时为默认信息
    static var user = Player(json: JSON())

    static func refreshPlayerInfo() {
        TMNetWork.post("/player/update", dataParameters: [
            "id": UserDefault.user.id,
            "loginName": UserDefault.user.loginName,
            "name": UserDefault.user.name,
            "icon": UserDefault.user.icon,
            "sex": UserDefault.user.sex,
            "age": UserDefault.user.age,
            "yearsPlayed": UserDefault.user.yearsPlayed,
            "height": UserDefault.user.height,
            "width": UserDefault.user.width,
            "grip": UserDefault.user.grip,
            "backhand": UserDefault.user.backhand,
        ]) { data, error in
            guard error == nil else {
                print(error!)
                return
            }
            UserDefault.user = Player(json: data ?? JSON())
        }
    }

    static func signIn(with loginName: String) {
        TMNetWork.post("/player/getInfo", dataParameters: [
            "loginName": loginName,
        ]) { data, error in
            guard error == nil else {
                print(error!)
                return
            }
            UserDefault.user = Player(json: data ?? JSON())
        }
    }

    static func signUp(with player: Player) {
        TMNetWork.post("/player/addPlayer", dataParameters: [
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

    static func AddFriend(_ loginName: String) {
        TMNetWork.post("/player/addFriend", dataParameters: ["loginName": loginName]) { data, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard data != nil else {
                return
            }
            UserDefault.user.friends = data!["friends"].arrayValue.map { Player(json: $0) }
        }
    }

    static func deleteFriend(_ loginName: String) {
        TMNetWork.post("/player/deleteFriend", dataParameters: ["loginName": loginName]) { data, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard data != nil else {
                return
            }
            UserDefault.user.friends = data!["friends"].arrayValue.map { Player(json: $0) }
        }
    }

    static func savePiece(_ game: Game) {
        UserDefaults.setValue(game, forKey: "pieceWith\(game.player2.loginName)")
    }
}
