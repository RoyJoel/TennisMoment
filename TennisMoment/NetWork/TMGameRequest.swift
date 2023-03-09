//
//  TMGameRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import CoreLocation
import Foundation

class TMGameRequest {
    static func addGame(game: Game, completionHandler: @escaping (Bool) -> Void) {
        TMLocationManager.shared.startPositioning { location in
            TMNetWork.post("/game/add", dataParameters: [
                "date": game.date,
                "place": location,
                "surface": game.surface.rawValue,
                "setNum": game.setNum,
                "gameNum": game.gameNum,
                "isGoldenGoal": game.isGoldenGoal,
                "isPlayer1Serving": game.isPlayer1Serving,
                "isCompleted": false,
                "player1LoginName": game.player1LoginName,
                "player1StatsId": 0,
                "player2LoginName": game.player2LoginName,
                "player2StatsId": 0,
                "isPlayer1FirstServe": true,
                "isPlayer2FirstServe": true,
                "result": [[[0, 0]]],
            ]) { json in
                guard let json = json else {
                    return
                }
                completionHandler(json.boolValue)
            }
        }
    }

    static func updateGame(game: Game, completionHandler: @escaping (Game) -> Void) {
        TMNetWork.post("/game/update", dataParameters: [
            "date": game.date,
            "place": game.place,
            "surface": game.surface.rawValue,
            "isCompleted": game.isCompleted,
            "isPlayer1Serving": game.isPlayer1Serving,
            "player1LoginName": game.player1LoginName,
            "player1StatsId": game.player1StatsId,
            "player2LoginName": game.player2LoginName,
            "isPlayer1FirstServe": game.isPlayer1FirstServe,
            "isPlayer2FirstServe": game.isPlayer2FirstServe,
            "result": game.result,
        ]) { json in
            guard let json = json else {
                return
            }
            completionHandler(Game(json: json))
        }
    }

    static func searchGame(for player1LoginName: String, and player2loginName: String, completionHandler: @escaping ([Game]) -> Void) {
        TMNetWork.post("/game/search", dataParameters: [
            "player1LoginName": player1LoginName,
            "player2LoginName": player2loginName,
        ]) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Game(json: $0) })
        }
    }

    static func searchAllGames(for loginName: String, completionHandler: @escaping ([Game]) -> Void) {
        TMNetWork.post("/game/searchAll", dataParameters: [
            "loginName": loginName,
        ]) { json in
            guard let json = json else {
                return
            }
            completionHandler(json.arrayValue.map { Game(json: $0) })
        }
    }
}
