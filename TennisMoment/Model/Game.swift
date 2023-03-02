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
    var id: Int
    var date: TimeInterval
    var place: String
    var surface: SurfaceType
    var setNum: Int
    var gameNum: Int
    var isGoldenGoal: Bool
    var isCompleted: Bool
    var player1: Player
    var player1Stats: Stats
    var player2: Player
    var player2Stats: Stats

    init(id: Int, date: TimeInterval, place: String, surface: SurfaceType, setNum: Int, gameNum: Int, isGoldenGoal: Bool, isCompleted: Bool, player1: Player, player1Stats: Stats, player2: Player, player2Stats: Stats) {
        self.id = id
        self.date = date
        self.place = place
        self.surface = surface
        self.setNum = setNum
        self.gameNum = gameNum
        self.isGoldenGoal = isGoldenGoal
        self.isCompleted = isCompleted
        self.player1 = player1
        self.player1Stats = player1Stats
        self.player2 = player2
        self.player2Stats = player2Stats
    }

    init(json: JSON) {
        id = json["id"].intValue
        date = json["date"].doubleValue
        place = json["place"].stringValue
        surface = SurfaceType(rawValue: json["surface"].stringValue) ?? .hard
        setNum = json["setNum"].intValue
        gameNum = json["gameNum"].intValue
        isGoldenGoal = json["isGoldenGoal"].boolValue
        isCompleted = json["isCompleted"].boolValue
        player1 = Player(json: json["player1"])
        player1Stats = Stats(json: json["player1Stats"])
        player2 = Player(json: json["player2"])
        player2Stats = Stats(json: json["player2"])
    }

    func toJSON() -> JSON {
        return JSON([
            "id": self.id,
            "date": self.date,
            "place": self.place,
            "surface": self.surface.rawValue,
            "setNum": self.setNum,
            "gameNum": self.gameNum,
            "isGoldenGoal": self.isGoldenGoal,
            "isCompleted": self.isCompleted,
            "player1": self.player1.toJSON(),
            "player1Stats": self.player1Stats.toJSON(),
            "player2": self.player2.toJSON(),
            "player2Stats": self.player2Stats.toJSON(),
        ])
    }
}

enum SurfaceType: String {
    case hard
    case grass
    case clay
}
