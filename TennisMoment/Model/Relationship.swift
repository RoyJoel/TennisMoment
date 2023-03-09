//
//  Relationship.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/4.
//

import Foundation
import SwiftyJSON

struct Relationship {
    var loginName: String
    var friendLoginName: String

    init(loginName: String, friendLoginName: String) {
        self.loginName = loginName
        self.friendLoginName = friendLoginName
    }

    init(json: JSON) {
        loginName = json["loginName"].stringValue
        friendLoginName = json["friendLoginName"].stringValue
    }
}
