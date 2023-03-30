//
//  User.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/28.
//

import Alamofire
import CoreLocation
import Foundation
import SwiftyJSON
import UIKit

class TMUser {
    // 未登录时为默认信息
    static var user = User(id: 1, loginName: "Jason Zhang", name: "Jason Zhang", icon: "JasonZhang", sex: .Man, age: 21, yearsPlayed: 1, height: 171, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON()), friends: [], allClubs: [], allGames: [], allTourLevelGames: [], allEvents: [], allSchedules: [])

//    static func updateUserInfo(completionHandler: @escaping (Player) -> Void) {
//        TMPlayerRequest.updatePlayerInfo(player: TMUser.user) { player in
//            completionHandler(player)
//        }
//    }
//
    static func signIn(completionHandler: @escaping () -> Void) {
        let para = [
            "id": TMUser.user.id,
        ]
        TMNetWork.post("/user/signIn", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            TMUser.user = User(json: json)
            completionHandler()
        }
    }

    static func signUp(completionHandler: @escaping (User) -> Void) {
        TMNetWork.post("/user/signUp", dataParameters: TMUser.user, responseBindingType: User.self) { response in
            guard let res = response else {
                return
            }
            completionHandler(res)
        }
    }

    static func addFriend(_ friendId: Int, completionHandler: @escaping ([Player]) -> Void) {
        let para = [
            "player1Id": TMUser.user.id,
            "player2Id": friendId,
        ]
        TMNetWork.post("/friend/add", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Player(json: $0) })
        }
    }

    static func deleteFriend(_ friendId: Int, completionHandler: @escaping ([Player]) -> Void) {
        let para = [
            "player1Id": TMUser.user.id,
            "player2Id": friendId,
        ]
        TMNetWork.post("/friend/delete", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Player(json: $0) })
        }
    }

    static func getAllFriends(completionHandler: @escaping ([Player]) -> Void) {
        let para = [
            "player1Id": TMUser.user.id,
        ]
        TMNetWork.post("/friend/getAll", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Player(json: $0) })
        }
    }

    static func searchFriend(_ friendId: Int, completionHandler: @escaping (Bool) -> Void) {
        let para = [
            "player1Id": TMUser.user.id,
            "player2Id": friendId,
        ]
        TMNetWork.post("/friend/search", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.boolValue)
        }
    }

    static func getLocationdescription(completionHandler: @escaping (String) -> Void) {
        TMLocationManager.shared.startPositioning { _, location in
            completionHandler(location)
        }
    }

    static func getLocationCoor(completionHandler: @escaping (CLLocation) -> Void) {
        TMLocationManager.shared.startPositioning { location, _ in
            completionHandler(location)
        }
    }

    static func addSchedule(startDate: TimeInterval, place: String, OpponentId: Int, completionHandler: @escaping (Schedule) -> Void) {
        TMNetWork.post("/schedule/add", dataParameters: [
            "startDate": startDate,
            "place": place,
            "player1Id": TMUser.user.id,
            "player2Id": OpponentId,
        ]) { res in
            guard let res = res else {
                return
            }
            completionHandler(Schedule(json: res))
        }
    }
}
