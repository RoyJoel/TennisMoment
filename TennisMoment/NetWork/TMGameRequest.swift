//
//  TMGameRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Alamofire
import CoreLocation
import Foundation
import SwiftyJSON

class TMGameRequest {
    static func addGame(game: Game, completionHandler: @escaping (Game?) -> Void) {
        TMNetWork.post("/game/add", dataParameters: [
            "date": game.date,
            "place": game.place,
            "surface": game.surface.rawValue,
            "setNum": game.setNum,
            "gameNum": game.gameNum,
            "isGoldenGoal": game.isGoldenGoal,
            "isPlayer1Serving": game.isPlayer1Serving,
            "isPlayer1Left": game.isPlayer1Left,
            "isChangePosition": game.isChangePosition,
            "isCompleted": game.isCompleted,
            "player1LoginName": game.player1LoginName,
            "player1StatsId": game.player1StatsId,
            "player2LoginName": game.player2LoginName,
            "player2StatsId": game.player2StatsId,
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

    static func updateGameAndStats(game: Game, stats1: Stats, stats2: Stats, completionHandler: @escaping ((Game, Stats, Stats)) -> Void) {
        let param = updateGameRequest(game: game, stats1: stats1, stats2: stats2)

        TMNetWork.post("/game/update", dataParameters: param, responseBindingType: updateGameResponse.self) { response in
            guard let res = response else {
                return
            }
            completionHandler((res.data.game, res.data.stats1, res.data.stats2))
        }
    }

    static func SearchRecentGames(playerLoginName: String, num: Int, completionHandler: @escaping (gameAndStatsArray) -> Void) {
        TMNetWork.post("/game/searchRecent", dataParameters: [
            "loginName": playerLoginName,
            "limit": num,
        ], responseBindingType: searchRecentGamesResponse.self) { response in
            guard let res = response else {
                let gameAndStatsArray = gameAndStatsArray(datas: [])
                completionHandler(gameAndStatsArray)
                return
            }
            completionHandler(res.data)
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
