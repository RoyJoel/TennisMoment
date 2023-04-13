//
//  Schedule.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/28.
//

import Foundation
import SwiftyJSON

struct Schedule: Codable, Equatable {
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

    // 将 Schedule 对象转换为字典
    func toDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "startDate": startDate,
            "place": place,
            "opponent": opponent.toDictionary(),
        ]
        return dictionary
    }

    // 将字典转换为 Schedule 对象
    init?(dictionary: [String: Any]) {
        guard let startDate = dictionary["startDate"] as? TimeInterval,
            let place = dictionary["place"] as? String,
            let opponentDict = dictionary["opponent"] as? [String: Any],
            let opponent = Player(dictionary: opponentDict) else {
            return nil
        }
        self = Schedule(startDate: startDate, place: place, opponent: opponent)
    }

    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return lhs.startDate == rhs.startDate &&
            lhs.place == rhs.place &&
            lhs.opponent == rhs.opponent
    }
}

struct ScheduleResponse: Codable {
    var code: Int
    var count: Int
    var msg: String
    var data: Schedule
}
