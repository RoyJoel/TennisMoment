//
//  TMSettingKeys.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/4/6.
//

import Foundation

enum AppearanceSetting: String {
    case Light
    case Dark
    case UnSpecified

    var userDisplayName: String {
        switch self {
        case .Light: return "Always Light"
        case .Dark: return "Always Dark"
        case .UnSpecified: return "System"
        }
    }

    init(userDisplayName: String) {
        switch userDisplayName {
        case "Always Light": self = .Light
        case "Always Dark": self = .Dark
        case "System": self = .UnSpecified
        default:
            self = .UnSpecified
        }
    }
}

enum LanguageSetting: String {
    case Ch = "zh-Hans"
    case En = "en"
    case Fr = "fr"
    case Es = "es"
    case De = "de"

    var userDisplayName: String {
        switch self {
        case .Ch: return "Chinese"
        case .En: return "English"
        case .Fr: return "French"
        case .Es: return "Spanish"
        case .De: return "German"
        }
    }

    init(userDisplayName: String) {
        switch userDisplayName {
        case "Chinese": self = .Ch
        case "English": self = .En
        case "French": self = .Fr
        case "Spanish": self = .Es
        case "German": self = .De
        default:
            self = .Ch
        }
    }
}
