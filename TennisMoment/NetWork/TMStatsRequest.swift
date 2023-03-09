//
//  TMStatsRequest.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/4.
//

import Foundation

class TMStatsRequest {
    static func searchStats(id: Int, completionHandler: @escaping (Stats) -> Void) {
        TMNetWork.post("/stats/search", dataParameters: ["id": id]) { json in
            guard let json = json else {
                return
            }
            completionHandler(Stats(json: json))
        }
    }

    static func getStatsInfoByPlayerLoginName(_ loginName: String, completionHandler: @escaping (Stats) -> Void) {
        TMNetWork.post("/stats/getInfo", dataParameters: ["loginName": loginName]) { json in
            guard let json = json else {
                return
            }
            completionHandler(Stats(json: json))
        }
    }

    static func updateStats(stats: Stats, completionHandler: @escaping (Stats) -> Void) {
        let para = [
            "id": stats.id,
            "aces": stats.aces,
            "doubleFaults": stats.doubleFaults,
            "servePoints": stats.servePoints,
            "firstServePoints": stats.firstServePoints,
            "firstServePointsIn": stats.firstServePointsIn,
            "firstServePointsWon": stats.firstServePointsWon,
            "secondServePointsWon": stats.secondServePointsWon,
            "breakPointsFaced": stats.breakPointsFaced,
            "breakPointsSaved": stats.breakPointsSaved,
            "serveGamesPlayed": stats.serveGamesPlayed,
            "serveGamesWon": stats.serveGamesWon,
            "returnAces": stats.returnAces,
            "returnServePoints": stats.returnServePoints,
            "firstServeReturnPoints": stats.firstServeReturnPoints,
            "firstServeReturnPointsWon": stats.firstServeReturnPointsWon,
            "secondServeReturnPointsWon": stats.secondServeReturnPointsWon,
            "breakPointsOpportunities": stats.breakPointsOpportunities,
            "breakPointsConverted": stats.breakPointsConverted,
            "returnGamesPlayed": stats.returnGamesPlayed,
            "returnGamesWon": stats.returnGamesWon,
            "netPoints": stats.netPoints,
            "unforcedErrors": stats.unforcedErrors,
            "forehandWinners": stats.forehandWinners,
            "backhandWinners": stats.backhandWinners,
        ]
        TMNetWork.post("/stats/update", dataParameters: para) { json in
            guard let json = json else {
                return
            }
            completionHandler(Stats(json: json))
        }
    }
}
