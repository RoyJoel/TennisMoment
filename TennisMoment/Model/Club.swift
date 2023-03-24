//
//  CLub.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/14.
//

import Foundation
import SwiftyJSON

struct Club: Codable {
    var id: Int
    var icon: String
    var name: String
    var intro: String
    var owner: Player
    var address: String
    var events: [Event]

    init(id: Int, icon: String, name: String, intro: String, owner: Player, address: String, events: [Event]) {
        self.id = id
        self.icon = icon
        self.name = name
        self.intro = intro
        self.owner = owner
        self.address = address
        self.events = events
    }

    init(json: JSON) {
        id = json["id"].intValue
        icon = json["icon"].stringValue
        name = json["name"].stringValue
        intro = json["intro"].stringValue
        owner = Player(json: json["owner"])
        address = json["address"].stringValue
        events = json["events"].arrayValue.map { Event(json: $0) }
    }
}
