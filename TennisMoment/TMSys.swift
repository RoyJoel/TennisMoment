//
//  TMSys.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation
import TABAnimated

class TMSys {
    static let shard = TMSys()

    private init() {}
    func start() {
        TABAnimated.shared().initWithOnlySkeleton()
        TABAnimated.shared().openLog = true
    }

    func setUserData(completionHandler: @escaping () -> Void) {
        TMUser.signIn {
            completionHandler()
        }
    }
}
