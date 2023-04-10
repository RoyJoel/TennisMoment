//
//  User.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/19.
//

import Foundation
import SwiftyJSON

struct User: Codable {
    var id: Int
    var loginName: String
    var password: String
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
    var friends: [Player]
    var allClubs: [Club]
    var allGames: [Game]
    var allTourLevelGames: [Game]
    var allEvents: [Event]
    var allSchedules: [Schedule]
    var token: String

    init(id: Int, loginName: String, password: String, name: String, icon: String, sex: Sex, age: Int, yearsPlayed: Int, height: Float, width: Float, grip: Grip, backhand: Backhand, points: Int, isAdult: Bool, careerStats: Stats, friends: [Player], allClubs: [Club], allGames: [Game], allTourLevelGames: [Game], allEvents: [Event], allSchedules: [Schedule], token: String) {
        self.id = id
        self.loginName = loginName
        self.password = password
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
        self.allClubs = allClubs
        self.allGames = allGames
        self.allTourLevelGames = allTourLevelGames
        self.allEvents = allEvents
        self.allSchedules = allSchedules
        self.token = token
    }

    init(json: JSON) {
        id = json["id"].intValue
        loginName = json["loginName"].stringValue
        password = json["password"].stringValue
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
        friends = json["friends"].arrayValue.map { Player(json: $0) }
        allClubs = json["allClubs"].arrayValue.map { Club(json: $0) }
        allGames = json["allGames"].arrayValue.map { Game(json: $0) }
        allTourLevelGames = json["allTourLevelGames"].arrayValue.map { Game(json: $0) }
        allEvents = json["allEvents"].arrayValue.map { Event(json: $0) }
        allSchedules = json["allSchedules"].arrayValue.map { Schedule(json: $0) }
        token = json["token"].stringValue
    }

    init() {
        self = User(json: JSON())
    }
}

struct signupResponse: Codable {
    var user: User
    var res: Bool
}

struct UserSignUpResponse: Codable {
    var code: Int
    var count: Int
    var data: signupResponse
}

struct UserResponse: Codable {
    var code: Int
    var count: Int
    var data: User
}
