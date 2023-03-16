//
//  Player.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct Player: Codable {
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
    var careerStatsId: Int
    var friends: String

    init(loginName: String, name: String, icon: String, sex: Sex, age: Int, yearsPlayed: Int, height: Float, width: Float, grip: Grip, backhand: Backhand, points: Int, isAdult: Bool, careerStatsId: Int, friends: String) {
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
        self.careerStatsId = careerStatsId
        self.friends = friends
    }

    init(json: JSON) {
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
        careerStatsId = json["careerStatsId"].intValue
        friends = json["friends"].stringValue
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
}

enum Backhand: String, Codable {
    case OneHandedBackhand
    case TwoHandedBackhand
}
