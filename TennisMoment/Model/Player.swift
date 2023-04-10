//
//  Player.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct Player: Codable {
    var id: Int
    var loginName: String
    var name: String
    var icon: String
    var sex: Sex
    var age: Int
    var yearsPlayed: Int
    var height: Float
    var width: Float
    var grip: Grip
    var backhand: Backhand
    var points: Int
    var isAdult: Bool
    var careerStats: Stats

    init(id: Int, loginName: String, name: String, icon: String, sex: Sex, age: Int, yearsPlayed: Int, height: Float, width: Float, grip: Grip, backhand: Backhand, points: Int, isAdult: Bool, careerStats: Stats) {
        self.id = id
        self.loginName = loginName
        self.name = name
        self.icon = icon
        self.sex = sex
        self.age = age
        self.yearsPlayed = yearsPlayed
        self.height = height
        self.width = width
        self.grip = grip
        self.backhand = backhand
        self.points = points
        self.isAdult = isAdult
        self.careerStats = careerStats
    }

    init(json: JSON) {
        id = json["id"].intValue
        loginName = json["loginName"].stringValue
        name = json["name"].stringValue
        icon = json["icon"].stringValue
        sex = Sex(rawValue: json["sex"].stringValue) ?? .Man
        age = json["age"].intValue
        yearsPlayed = json["yearsPlayed"].intValue
        height = json["height"].floatValue
        width = json["width"].floatValue
        grip = Grip(rawValue: json["grip"].stringValue) ?? .Continented
        backhand = Backhand(rawValue: json["backhand"].stringValue) ?? .TwoHandedBackhand
        points = json["points"].intValue
        isAdult = json["isAdult"].boolValue
        careerStats = Stats(json: json["careerStats"])
    }

    init() {
        self = Player(json: JSON())
    }
}

enum Sex: String, Codable {
    case Man
    case Woman
}

enum Grip: String, Codable {
    case Continented
    case Eastern
    case SemiWestern
    case Western

    var index: String {
        switch self {
        case .Continented: return "0"
        case .Eastern: return "1"
        case .SemiWestern: return "2"
        case .Western: return "3"
        }
    }
}

enum Backhand: String, Codable {
    case OneHanded = "One-Handed"
    case TwoHandedBackhand = "Two-Handed"

    var index: String {
        switch self {
        case .OneHanded: return "0"
        case .TwoHandedBackhand: return "1"
        }
    }
}
