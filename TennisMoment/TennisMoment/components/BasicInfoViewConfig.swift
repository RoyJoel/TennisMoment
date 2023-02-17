//
//  HomeBasicInfoViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/27.
//

import Foundation

class TMInfoViewConfig: TMComponentConfig {
    var iconName: String?
    var name: String
    init(iconName: String?, name: String) {
        self.iconName = iconName
        self.name = name
    }

    static func defaultConfig() -> TMComponentConfig {
        return TMInfoViewConfig(iconName: nil, name: "")
    }
}
