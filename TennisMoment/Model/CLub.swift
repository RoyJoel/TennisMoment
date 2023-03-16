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
    var ownerId: Int
    var address: String

    init(id: Int, icon: String, name: String, intro: String, ownerId: Int, address: String) {
        self.id = id
        self.icon = icon
        self.name = name
        self.intro = intro
        self.ownerId = ownerId
        self.address = address
    }

    init(json: JSON) {
        id = json["id"].intValue
        icon = json["icon"].stringValue
        name = json["name"].stringValue
        intro = json["intro"].stringValue
        ownerId = json["ownerId"].intValue
        address = json["address"].stringValue
    }
}
