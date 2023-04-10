//
//  Game.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import CoreLocation
import Foundation
import SwiftyJSON

struct Game: Codable {
    var id: Int
    var place: String
    var surface: SurfaceType
    var setNum: Int
    var gameNum: Int
    var round: Int
    var isGoldenGoal: Bool
    var isPlayer1Serving: Bool
    var isPlayer1Left: Bool
    var isChangePosition: Bool
    var startDate: TimeInterval
    var endDate: TimeInterval
    var player1: Player
    var player1Stats: Stats
    var player2: Player
    var player2Stats: Stats
    var isPlayer1FirstServe: Bool
    var isPlayer2FirstServe: Bool
    var result: [[[Int]]]

    init(id: Int, place: String, surface: SurfaceType, setNum: Int, gameNum: Int, round: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool, isPlayer1Left: Bool, isChangePosition: Bool, startDate: TimeInterval, endDate: TimeInterval, player1: Player, player1Stats: Stats, player2: Player, player2Stats: Stats, isPlayer1FirstServe: Bool, isPlayer2FirstServe: Bool, result: [[[Int]]]) {
        self.id = id
        self.place = place
        self.surface = surface
        self.setNum = setNum
        self.gameNum = gameNum
        self.round = round
        self.isGoldenGoal = isGoldenGoal
        self.isPlayer1Serving = isPlayer1Serving
        self.isPlayer1Left = isPlayer1Left
        self.isChangePosition = isChangePosition
        self.startDate = startDate
        self.endDate = endDate
        self.player1 = player1
        self.player1Stats = player1Stats
        self.player2 = player2
        self.player2Stats = player2Stats
        self.isPlayer1FirstServe = isPlayer1FirstServe
        self.isPlayer2FirstServe = isPlayer2FirstServe
        self.result = result
    }

    init(json: JSON) {
        id = json["id"].intValue
        place = json["place"].stringValue
        surface = SurfaceType(rawValue: json["surface"].stringValue) ?? .hard
        setNum = json["setNum"].intValue
        gameNum = json["gameNum"].intValue
        round = json["round"].intValue
        isGoldenGoal = json["isGoldenGoal"].boolValue
        isPlayer1Serving = json["isPlayer1Serving"].boolValue
        isPlayer1Left = json["isPlayer1Left"].boolValue
        isChangePosition = json["isChangePosition"].boolValue
        startDate = json["startDate"].doubleValue
        endDate = json["endDate"].doubleValue
        player1 = Player(json: json["player1"])
        player1Stats = Stats(json: json["player1Stats"])
        player2 = Player(json: json["player2"])
        player2Stats = Stats(json: json["player2Stats"])
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

    init() {
        self = Game(json: JSON())
    }
}

enum SurfaceType: String, Codable, CaseIterable {
    case hard
    case grass
    case clay
}

struct GameRequest: Codable {
    var id: Int
    var place: String
    var surface: SurfaceType
    var setNum: Int
    var gameNum: Int
    var round: Int
    var isGoldenGoal: Bool
    var isPlayer1Serving: Bool
    var isPlayer1Left: Bool
    var isChangePosition: Bool
    var startDate: TimeInterval
    var endDate: TimeInterval?
    var player1Id: Int
    var player1StatsId: Int
    var player2Id: Int
    var player2StatsId: Int
    var isPlayer1FirstServe: Bool
    var isPlayer2FirstServe: Bool
    var result: [[[Int]]]

    init(id: Int, place: String, surface: SurfaceType, setNum: Int, gameNum: Int, round: Int, isGoldenGoal: Bool, isPlayer1Serving: Bool, isPlayer1Left: Bool, isChangePosition: Bool, startDate: TimeInterval, endDate: TimeInterval? = nil, player1Id: Int, player1StatsId: Int, player2Id: Int, player2StatsId: Int, isPlayer1FirstServe: Bool, isPlayer2FirstServe: Bool, result: [[[Int]]]) {
        self.id = id
        self.place = place
        self.surface = surface
        self.setNum = setNum
        self.gameNum = gameNum
        self.round = round
        self.isGoldenGoal = isGoldenGoal
        self.isPlayer1Serving = isPlayer1Serving
        self.isPlayer1Left = isPlayer1Left
        self.isChangePosition = isChangePosition
        self.startDate = startDate
        self.endDate = endDate
        self.player1Id = player1Id
        self.player1StatsId = player1StatsId
        self.player2Id = player2Id
        self.player2StatsId = player2StatsId
        self.isPlayer1FirstServe = isPlayer1FirstServe
        self.isPlayer2FirstServe = isPlayer2FirstServe
        self.result = result
    }

    init(json: JSON) {
        id = json["id"].intValue
        place = json["place"].stringValue
        surface = SurfaceType(rawValue: json["surface"].stringValue) ?? .hard
        setNum = json["setNum"].intValue
        gameNum = json["gameNum"].intValue
        round = json["round"].intValue
        isGoldenGoal = json["isGoldenGoal"].boolValue
        isPlayer1Serving = json["isPlayer1Serving"].boolValue
        isPlayer1Left = json["isPlayer1Left"].boolValue
        isChangePosition = json["isChangePosition"].boolValue
        startDate = json["startDate"].doubleValue
        endDate = json["endDate"].doubleValue
        player1Id = json["player1Id"].intValue
        player1StatsId = json["player1Stats"].intValue
        player2Id = json["player2"].intValue
        player2StatsId = json["player2Stats"].intValue
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
}

struct GameResponse: Codable {
    var code: Int
    var count: Int
    var msg: String
    var data: Game
}
