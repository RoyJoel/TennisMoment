//
//  CareerStats.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct Stats: Codable {
    var id: Int
    var aces: Int
    var doubleFaults: Int
    var servePoints: Int
    var firstServePoints: Int
    var firstServePointsIn: Int
    var firstServePointsWon: Int
    var secondServePointsIn: Int
    var secondServePointsWon: Int
    var breakPointsFaced: Int
    var breakPointsSaved: Int
    var serveGamesPlayed: Int
    var serveGamesWon: Int
    var returnAces: Int
    var returnServePoints: Int
    var firstServeReturnPoints: Int
    var firstServeReturnPointsIn: Int
    var firstServeReturnPointsWon: Int
    var secondServeReturnPointsIn: Int
    var secondServeReturnPointsWon: Int
    var breakPointsOpportunities: Int
    var breakPointsConverted: Int
    var returnGamesPlayed: Int
    var returnGamesWon: Int
    var netPoints: Int
    var unforcedErrors: Int
    var forehandWinners: Int
    var backhandWinners: Int

    init(id: Int, aces: Int, doubleFaults: Int, servePoints: Int, firstServePoints: Int, firstServePointsIn: Int, firstServePointsWon: Int, secondServePointsIn: Int, secondServePointsWon: Int, breakPointsFaced: Int, breakPointsSaved: Int, serveGamesPlayed: Int, serveGamesWon: Int, returnAces: Int, returnServePoints: Int, firstServeReturnPoints: Int, firstServeReturnPointsIn: Int, firstServeReturnPointsWon: Int, secondServeReturnPointsIn: Int, secondServeReturnPointsWon: Int, breakPointsOpportunities: Int, breakPointsConverted: Int, returnGamesPlayed: Int, returnGamesWon: Int, netPoints: Int, unforcedErrors: Int, forehandWinners: Int, backhandWinners: Int) {
        self.id = id
        self.aces = aces
        self.doubleFaults = doubleFaults
        self.servePoints = servePoints
        self.firstServePoints = firstServePoints
        self.firstServePointsIn = firstServePointsIn
        self.firstServePointsWon = firstServePointsWon
        self.secondServePointsIn = secondServePointsIn
        self.secondServePointsWon = secondServePointsWon
        self.breakPointsFaced = breakPointsFaced
        self.breakPointsSaved = breakPointsSaved
        self.serveGamesPlayed = serveGamesPlayed
        self.serveGamesWon = serveGamesWon
        self.returnAces = returnAces
        self.returnServePoints = returnServePoints
        self.firstServeReturnPoints = firstServeReturnPoints
        self.firstServeReturnPointsIn = firstServeReturnPointsIn
        self.firstServeReturnPointsWon = firstServeReturnPointsWon
        self.secondServeReturnPointsIn = secondServeReturnPointsIn
        self.secondServeReturnPointsWon = secondServeReturnPointsWon
        self.breakPointsOpportunities = breakPointsOpportunities
        self.breakPointsConverted = breakPointsConverted
        self.returnGamesPlayed = returnGamesPlayed
        self.returnGamesWon = returnGamesWon
        self.netPoints = netPoints
        self.unforcedErrors = unforcedErrors
        self.forehandWinners = forehandWinners
        self.backhandWinners = backhandWinners
    }

    init(json: JSON) {
        id = json["id"].intValue
        aces = json["aces"].intValue
        doubleFaults = json["doubleFaults"].intValue
        servePoints = json["servePoints"].intValue
        firstServePoints = json["firstServePoints"].intValue
        firstServePointsIn = json["firstServePointsIn"].intValue
        firstServePointsWon = json["firstServePointsWon"].intValue
        secondServePointsIn = json["secondServePointsIn"].intValue
        secondServePointsWon = json["secondServePointsWon"].intValue
        breakPointsFaced = json["breakPointsFaced"].intValue
        breakPointsSaved = json["breakPointsSaved"].intValue
        serveGamesPlayed = json["serveGamesPlayed"].intValue
        serveGamesWon = json["serveGamesWon"].intValue
        returnAces = json["returnAces"].intValue
        returnServePoints = json["returnServePoints"].intValue
        firstServeReturnPoints = json["firstServeReturnPoints"].intValue
        firstServeReturnPointsIn = json["firstServeReturnPointsIn"].intValue
        firstServeReturnPointsWon = json["firstServeReturnPointsWon"].intValue
        secondServeReturnPointsIn = json["secondServeReturnPointsIn"].intValue
        secondServeReturnPointsWon = json["secondServeReturnPointsWon"].intValue
        breakPointsOpportunities = json["breakPointsOpportunities"].intValue
        breakPointsConverted = json["breakPointsConverted"].intValue
        returnGamesPlayed = json["returnGamesPlayed"].intValue
        returnGamesWon = json["returnGamesWon"].intValue
        netPoints = json["netPoints"].intValue
        unforcedErrors = json["unforcedErrors"].intValue
        forehandWinners = json["forehandWinners"].intValue
        backhandWinners = json["backhandWinners"].intValue
    }

    func toJSON() -> JSON {
        return JSON([
            "id": self.id,
            "aces": self.aces,
            "doubleFaults": self.doubleFaults,
            "servePoints": self.servePoints,
            "firstServePoints": self.firstServePoints,
            "firstServePointsIn": self.firstServePointsIn,
            "firstServePointsWon": self.firstServePointsWon,
            "secondServePointsIn": self.secondServePointsIn,
            "secondServePointsWon": self.secondServePointsWon,
            "breakPointsFaced": self.breakPointsFaced,
            "breakPointsSaved": self.breakPointsSaved,
            "serveGamesPlayed": self.serveGamesPlayed,
            "serveGamesWon": self.serveGamesWon,
            "returnAces": self.returnAces,
            "returnServePoints": self.returnServePoints,
            "firstServeReturnPoints": self.firstServeReturnPoints,
            "firstServeReturnPointsIn": self.firstServeReturnPointsIn,
            "firstServeReturnPointsWon": self.firstServeReturnPointsWon,
            "secondServeReturnPointsIn": self.secondServeReturnPointsIn,
            "secondServeReturnPointsWon": self.secondServeReturnPointsWon,
            "breakPointsOpportunities": self.breakPointsOpportunities,
            "breakPointsConverted": self.breakPointsConverted,
            "returnGamesPlayed": self.returnGamesPlayed,
            "returnGamesWon": self.returnGamesWon,
            "netPoints": self.netPoints,
            "unforcedErrors": self.unforcedErrors,
            "forehandWinners": self.forehandWinners,
            "backhandWinners": self.backhandWinners,
        ])
    }

    init() {
        self = Stats(json: JSON())
    }
}
