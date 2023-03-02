//
//  CareerStats.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct Stats {
    var aces: Int
    var doubleFaults: Int
    var firstServePoints: Int
    var firstServePointsIn: Int
    var firstServePointsWon: Int
    var secondServePoints: Int
    var secondServePointsWon: Int
    var breakPointsFaced: Int
    var breakPointsSaved: Int
    var serveGamesPlayed: Int
    var serveGamesWon: Int
    var totalServePointsWon: Int
    var firstServeReturnPoints: Int
    var firstServeReturnAces: Int
    var firstServeReturnPointsWon: Int
    var secondServeReturnPoints: Int
    var secondServeReturnAces: Int
    var secondServeReturnPointsWon: Int
    var breakPointsOpportunities: Int
    var breakPointsConverted: Int
    var returnGamesPlayed: Int
    var returnGamesWon: Int
    var totalReturnPointsWon: Int
    var totalPointsWon: Int
    var netPoints: Int
    var unforcedErrors: Int
    var forehandWinners: Int
    var backhandWinners: Int

    init(aces: Int, doubleFaults: Int, firstServePoints: Int, firstServePointsIn: Int, firstServePointsWon: Int, secondServePoints: Int, secondServePointsWon: Int, breakPointsFaced: Int, breakPointsSaved: Int, serveGamesPlayed: Int, serveGamesWon: Int, totalServePointsWon: Int, firstServeReturnPoints: Int, firstServeReturnAces: Int, firstServeReturnPointsWon: Int, secondServeReturnPoints: Int, secondServeReturnAces: Int, secondServeReturnPointsWon: Int, breakPointsOpportunities: Int, breakPointsConverted: Int, returnGamesPlayed: Int, returnGamesWon: Int, totalReturnPointsWon: Int, totalPointsWon: Int, netPoints: Int, unforcedErrors: Int, forehandWinners: Int, backhandWinners: Int) {
        self.aces = aces
        self.doubleFaults = doubleFaults
        self.firstServePoints = firstServePoints
        self.firstServePointsIn = firstServePointsIn
        self.firstServePointsWon = firstServePointsWon
        self.secondServePoints = secondServePoints
        self.secondServePointsWon = secondServePointsWon
        self.breakPointsFaced = breakPointsFaced
        self.breakPointsSaved = breakPointsSaved
        self.serveGamesPlayed = serveGamesPlayed
        self.serveGamesWon = serveGamesWon
        self.totalServePointsWon = totalServePointsWon
        self.firstServeReturnPoints = firstServeReturnPoints
        self.firstServeReturnAces = firstServeReturnAces
        self.firstServeReturnPointsWon = firstServeReturnPointsWon
        self.secondServeReturnPoints = secondServeReturnPoints
        self.secondServeReturnAces = secondServeReturnAces
        self.secondServeReturnPointsWon = secondServeReturnPointsWon
        self.breakPointsOpportunities = breakPointsOpportunities
        self.breakPointsConverted = breakPointsConverted
        self.returnGamesPlayed = returnGamesPlayed
        self.returnGamesWon = returnGamesWon
        self.totalReturnPointsWon = totalReturnPointsWon
        self.totalPointsWon = totalPointsWon
        self.netPoints = netPoints
        self.unforcedErrors = unforcedErrors
        self.forehandWinners = forehandWinners
        self.backhandWinners = backhandWinners
    }

    init(json: JSON) {
        aces = json["aces"].intValue
        doubleFaults = json["doubleFaults"].intValue
        firstServePoints = json["firstServePoints"].intValue
        firstServePointsIn = json["firstServePointsIn"].intValue
        firstServePointsWon = json["firstServePointsWon"].intValue
        secondServePoints = json["secondServePoints"].intValue
        secondServePointsWon = json["secondServePointsWon"].intValue
        breakPointsFaced = json["breakPointsFaced"].intValue
        breakPointsSaved = json["breakPointsSaved"].intValue
        serveGamesPlayed = json["serveGamesPlayed"].intValue
        serveGamesWon = json["serveGamesWon"].intValue
        totalServePointsWon = json["totalServePointsWon"].intValue
        firstServeReturnPoints = json["firstServeReturnPoints"].intValue
        firstServeReturnAces = json["firstServeReturnAces"].intValue
        firstServeReturnPointsWon = json["firstServeReturnPointsWon"].intValue
        secondServeReturnPoints = json["secondServeReturnPoints"].intValue
        secondServeReturnAces = json["secondServeReturnAces"].intValue
        secondServeReturnPointsWon = json["secondServeReturnPointsWon"].intValue
        breakPointsOpportunities = json["breakPointsOpportunities"].intValue
        breakPointsConverted = json["breakPointsConverted"].intValue
        returnGamesPlayed = json["returnGamesPlayed"].intValue
        returnGamesWon = json["returnGamesWon"].intValue
        totalReturnPointsWon = json["totalReturnPointsWon"].intValue
        totalPointsWon = json["totalPointsWon"].intValue
        netPoints = json["netPoints"].intValue
        unforcedErrors = json["unforcedErrors"].intValue
        forehandWinners = json["forehandWinners"].intValue
        backhandWinners = json["backhandWinners"].intValue
    }

    func toJSON() -> JSON {
        return JSON([
            "aces": aces,
            "doubleFaults": doubleFaults,
            "firstServePoints": firstServePoints,
            "firstServePointsIn": firstServePointsIn,
            "firstServePointsWon": firstServePointsWon,
            "secondServePoints": secondServePoints,
            "secondServePointsWon": secondServePointsWon,
            "breakPointsFaced": breakPointsFaced,
            "breakPointsSaved": breakPointsSaved,
            "serveGamesPlayed": serveGamesPlayed,
            "serveGamesWon": serveGamesWon,
            "totalServePointsWon": totalServePointsWon,
            "firstServeReturnPoints": firstServeReturnPoints,
            "firstServeReturnAces": firstServeReturnAces,
            "firstServeReturnPointsWon": firstServeReturnPointsWon,
            "secondServeReturnPoints": secondServeReturnPoints,
            "secondServeReturnAces": secondServeReturnAces,
            "secondServeReturnPointsWon": secondServeReturnPointsWon,
            "breakPointsOpportunities": breakPointsOpportunities,
            "breakPointsConverted": breakPointsConverted,
            "returnGamesPlayed": returnGamesPlayed,
            "returnGamesWon": returnGamesWon,
            "totalReturnPointsWon": totalReturnPointsWon,
            "totalPointsWon": totalPointsWon,
            "netPoints": netPoints,
            "unforcedErrors": unforcedErrors,
            "forehandWinners": forehandWinners,
            "backhandWinners": backhandWinners,
        ])
    }
}
