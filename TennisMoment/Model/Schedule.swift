//
//  Schedule.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import Foundation
import SwiftyJSON

struct Schedule: Codable {
    var startDate: TimeInterval
    var place: String
    var opponent: Player

    init(startDate: TimeInterval, place: String, opponent: Player) {
        self.startDate = startDate
        self.place = place
        self.opponent = opponent
    }

    init(json: JSON) {
        startDate = json["startDate"].doubleValue
        place = json["place"].stringValue
        opponent = Player(json: json["opponent"])
    }
}

struct ScheduleResponse: Codable {
    var code: Int
    var count: Int
    var msg: String
    var data: Schedule
}
