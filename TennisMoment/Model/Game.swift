//
//  Game.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import CoreLocation
import Foundation
import SwiftyJSON

struct Game {
    var date: TimeInterval
    var place: String
    var surface: SurfaceType
    var setNum: Int
    var gameNum: Int
    var isGoldenGoal: Bool
    var isPlayer1Serving: Bool
    var isCompleted: Bool
    var player1LoginName: String
    var player1StatsId: Int
    var player2LoginName: String
    var player2StatsId: Int
    var isPlayer1FirstServe: Bool
    var isPlayer2FirstServe: Bool
    var result: [[[Int]]]

    init(date: TimeInterval, place: String, surface: SurfaceType, setNum: Int, gameNum: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool, isCompleted: Bool, player1LoginName: String, player1StatsId: Int, player2LoginName: String, player2StatsId: Int, isPlayer1FirstServe: Bool, isPlayer2FirstServe: Bool, result: [[[Int]]]) {
        self.date = date
        self.place = place
        self.surface = surface
        self.setNum = setNum
        self.gameNum = gameNum
        self.isGoldenGoal = isGoldenGoal
        self.isPlayer1Serving = isPlayer1Serving
        self.isCompleted = isCompleted
        self.player1LoginName = player1LoginName
        self.player1StatsId = player1StatsId
        self.player2LoginName = player2LoginName
        self.player2StatsId = player2StatsId
        self.isPlayer1FirstServe = isPlayer1FirstServe
        self.isPlayer2FirstServe = isPlayer2FirstServe
        self.result = result
    }

    init(json: JSON) {
        date = json["date"].doubleValue
        place = json["place"].stringValue
        surface = SurfaceType(rawValue: json["surface"].stringValue) ?? .hard
        setNum = json["setNum"].intValue
        gameNum = json["gameNum"].intValue
        isGoldenGoal = json["isGoldenGoal"].boolValue
        isPlayer1Serving = json["isPlayer1Serving"].boolValue
        isCompleted = json["isCompleted"].boolValue
        player1LoginName = json["player1LoginName"].stringValue
        player1StatsId = json["player1StatsId"].intValue
        player2LoginName = json["player2LoginName"].stringValue
        player2StatsId = json["player2StatsId"].intValue
        isPlayer1FirstServe = json["isPlayer1FirstServe"].boolValue
        isPlayer2FirstServe = json["isPlayer2FirstServe"].boolValue
        if let array = json["result"].array {
            result = array.map { subarray in
                subarray.arrayValue.map { array in
                    array.arrayValue.map { num in
                        num.intValue
                    }
                }
            }
        } else {
            result = [[]]
        }
    }

    func toJSON() -> JSON {
        return JSON([
            "date": self.date,
            "place": self.place,
            "surface": self.surface.rawValue,
            "setNum": self.setNum,
            "gameNum": self.gameNum,
            "isGoldenGoal": self.isGoldenGoal,
            "isPlayer1Serving": self.isPlayer1Serving,
            "isCompleted": self.isCompleted,
            "player1LoginName": self.player1LoginName,
            "player1StatsId": self.player1StatsId,
            "player2LoginName": self.player2LoginName,
            "player2StatsId": self.player2StatsId,
            "isPlayer1FirstServe": self.isPlayer1FirstServe,
            "isPlayer2FirstServe": self.isPlayer2FirstServe,
            "result": JSON(self.result),
        ])
    }
}

enum SurfaceType: String {
    case hard
    case grass
    case clay
}
