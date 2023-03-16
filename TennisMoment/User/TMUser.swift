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

class TMUser {
    // 未登录时为默认信息
    static var user = Player(loginName: "Jason Zhang", name: "Jason Zhang", icon: "Jason Zhang", sex: .Man, age: 21, yearsPlayed: 1, height: 171, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStatsId: 3, friends: "Jason Zhang")

    static func updateUserInfo(completionHandler: @escaping (Player) -> Void) {
        TMPlayerRequest.updatePlayerInfo(player: TMUser.user) { player in
            completionHandler(player)
        }
    }

    static func signIn(completionHandler: @escaping (Player?) -> Void) {
        let para = [
            "loginName": TMUser.user.loginName,
        ]
        TMNetWork.post("/player/getInfo", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            TMUser.user = Player(json: json)
            completionHandler(TMUser.user)
        }
    }

    static func signUp(completionHandler: @escaping (Bool) -> Void) {
        TMPlayerRequest.searchPlayer(loginName: TMUser.user.loginName) { player in
            if player != nil {
                completionHandler(false)
            } else {
                TMPlayerRequest.addPlayer(player: TMUser.user) { _ in }
                completionHandler(true)
            }
        }
    }

    static func addFriend(_ friendLoginName: String, completionHandler: @escaping ([Relationship]) -> Void) {
        let para = [
            "loginName": TMUser.user.loginName,
            "friendLoginName": friendLoginName,
        ]
        TMNetWork.post("/friend/add", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Relationship(json: $0) })
        }
    }

    static func deleteFriend(_ friendLoginName: String, completionHandler: @escaping ([Relationship]) -> Void) {
        let para = [
            "loginName": TMUser.user.loginName,
            "friendLoginName": friendLoginName,
        ]
        TMNetWork.post("/friend/delete", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Relationship(json: $0) })
        }
    }

    static func getAllFriend(completionHandler: @escaping ([Relationship]) -> Void) {
        let para = [
            "loginName": TMUser.user.loginName,
        ]
        TMNetWork.post("/friend/getAll", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Relationship(json: $0) })
        }
    }

    static func searchFriend(_ friendLoginName: String, completionHandler: @escaping (Bool) -> Void) {
        let para = [
            "loginName": TMUser.user.loginName,
            "friendLoginName": friendLoginName,
        ]
        TMNetWork.post("/friend/search", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.boolValue)
        }
    }
}
