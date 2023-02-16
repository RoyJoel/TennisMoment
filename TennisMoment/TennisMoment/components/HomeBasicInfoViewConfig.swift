//
//  HomeBasicInfoViewConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/27.
//

import Foundation

class HomeBasicInfoViewConfig: TMConfig {
    var iconName: String?
    var name: String
    init(iconName: String? = nil, name: String) {
        self.iconName = iconName
        self.name = name
    }

    func defaultConfig() -> TMConfig {
        return HomeBasicInfoViewConfig(name: "")
    }
}
