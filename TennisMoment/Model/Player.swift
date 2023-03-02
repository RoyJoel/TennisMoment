//
//  Player.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/25.
//

import Foundation
import SwiftyJSON

struct Player {
    var id: Int
    var loginName: String
    var name: String
    var icon: UIImage
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
    var friends: [Player]
    var gamesPlayed: [Game]

    init(id: Int, loginName: String, name: String, icon: UIImage, sex: Sex, age: Int, yearsPlayed: Int, height: Float, width: Float, grip: Grip, backhand: Backhand, points: Int, isAdult: Bool, careerStats: Stats, friends: [Player], gamesPlayed: [Game]) {
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
        self.friends = friends
        self.gamesPlayed = gamesPlayed
    }

    init(json: JSON) {
        id = json["id"].intValue
        loginName = json["loginName"].stringValue
        name = json["name"].stringValue
        icon = UIImage(data: json["icon"].stringValue.data(using: .utf8) ?? Data()) ?? UIImage(systemName: "person")!
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
        friends = json["friends"].arrayValue.map { Player(json: $0) }
        gamesPlayed = json["gamesPlayed"].arrayValue.map { Game(json: $0) }
    }

    func toJSON() -> JSON {
        return JSON([
            "id": self.id,
            "loginName": self.loginName,
            "name": self.name,
            "icon": self.icon.pngData() ?? Data(),
            "sex": self.sex.rawValue,
            "age": self.age,
            "yearsPlayed": self.yearsPlayed,
            "height": self.height,
            "width": self.width,
            "grip": self.grip.rawValue,
            "backhand": self.backhand.rawValue,
            "points": self.points,
            "isAdult": self.isAdult,
            "careerStats": self.careerStats,
            "friends": self.friends,
            "gamesPlayed": self.gamesPlayed,
        ])
    }
}

enum Sex: String {
    case Man
    case Woman
}

enum Grip: String {
    case Continented
    case Eastern
    case SemiWestern
    case Western
}

enum Backhand: String {
    case OneHandedBackhand
    case TwoHandedBackhand
}
