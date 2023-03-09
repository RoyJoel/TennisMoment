//
//  TMDataConvert.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation

class TMDataConvert {
    static func read(from result: [[[Int]]], setConfigNum _: Int, gameConfigNum: Int) -> [[Int]] {
        var leftSetNum = 0
        var rightSetNum = 0
        var leftGameNum = 0
        var rightGameNum = 0
        var leftPointNum = 0
        var rightPointNum = 0

        for set in result.indices {
            for game in result[set].indices {
                if set == (result.count - 1), game == (result[set].count - 1), leftGameNum != gameConfigNum, rightGameNum != gameConfigNum {
                    leftPointNum = result[set][game][0]
                    rightPointNum = result[set][game][1]
                } else {
                    if result[set][game][0] > result[set][game][1] {
                        leftGameNum += 1
                        leftPointNum = 0
                        rightPointNum = 0
                    } else {
                        rightGameNum += 1
                        leftPointNum = 0
                        rightPointNum = 0
                    }
                }
            }
            if set != result.count - 1 {
                if leftGameNum > rightGameNum {
                    leftSetNum += 1
                    leftGameNum = 0
                    rightGameNum = 0
                } else {
                    rightSetNum += 1
                    leftGameNum = 0
                    rightGameNum = 0
                }
            }
        }

        return [[leftSetNum, rightSetNum], [leftGameNum, rightGameNum], [leftPointNum, rightPointNum]]
    }

    static func changePosition(with value1: inout Int, and value2: inout Int) {
        var t = value1
        value1 = value2
        value2 = t
    }
}
