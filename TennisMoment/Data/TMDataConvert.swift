//
//  TMDataConvert.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/6.
//

import Foundation

class TMDataConvert {
    static func read(from result: [[[Int]]], isGameCompleted: Bool, gameConfigNum: Int) -> ([[Int]], Bool) {
        var isInTieBreak = false
        var leftSetNum = 0
        var rightSetNum = 0
        var leftGameNum = 0
        var rightGameNum = 0
        var leftPointNum = 0
        var rightPointNum = 0

        for set in result.indices {
            for game in result[set].indices {
                if !result[set][game].isEmpty {
                    if set == (result.count - 1), game == (result[set].count - 1) {
                        if leftGameNum == gameConfigNum, rightGameNum == gameConfigNum {
                            leftPointNum = result[set][game][0]
                            rightPointNum = result[set][game][1]
                            isInTieBreak = true
                            continue
                        }
                        if result[set][game][0] > 5, result[set][game][0] > result[set][game][1] {
                            leftGameNum += 1
                            leftPointNum = 0
                            rightPointNum = 0
                            continue
                        } else if result[set][game][1] > 5, result[set][game][1] > result[set][game][0] {
                            rightGameNum += 1
                            leftPointNum = 0
                            rightPointNum = 0
                            continue
                        } else if result[set][game][0] == 5 {
                            leftGameNum += 1
                            leftPointNum = 0
                            rightPointNum = 0
                            continue
                        } else if result[set][game][1] == 5 {
                            rightGameNum += 1
                            leftPointNum = 0
                            rightPointNum = 0
                            continue
                        } else {
                            leftPointNum = result[set][game][0]
                            rightPointNum = result[set][game][1]
                            continue
                        }
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
            }
            if !result[set].isEmpty {
                if isGameCompleted {
                    if leftGameNum > rightGameNum {
                        leftSetNum += 1
                        leftGameNum = 0
                        rightGameNum = 0
                    } else {
                        rightSetNum += 1
                        leftGameNum = 0
                        rightGameNum = 0
                    }
                } else if set != result.count - 1 {
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
        }

        return ([[leftSetNum, rightSetNum], [leftGameNum, rightGameNum], [leftPointNum, rightPointNum]], isInTieBreak)
    }

    static func gameResult(from result: [[[Int]]]) -> [[Int]] {
        var res: [[Int]] = []
        for set in result {
            var player1SetResult = 0
            var player2SetResult = 0
            for game in set {
                if game[0] > game[1] {
                    player1SetResult += 1
                } else {
                    player2SetResult += 1
                }
            }
            res.append([player1SetResult, player2SetResult])
        }
        return res
    }

    static func setResult(from result: [[[Int]]]) -> [Int] {
        let gameResult = self.gameResult(from: result)
        var player1SetResult = 0
        var player2SetResult = 0
        for set in gameResult {
            if set[0] > set[1] {
                player1SetResult += 1
            } else {
                player2SetResult += 1
            }
        }
        return [player1SetResult, player2SetResult]
    }

    static func changePosition(with value1: inout Int, and value2: inout Int) {
        let t = value1
        value1 = value2
        value2 = t
    }

    static func Divide(_ dividend: Int, by divisor: Int) -> Double {
        if divisor == 0 {
            return 0
        } else {
            return Double(dividend) / Double(divisor)
        }
    }

    static func datesInRangeString(startDate: TimeInterval, endDate: TimeInterval) -> [String] {
        let calendar = Calendar.current
        var currentDate = Date(timeIntervalSince1970: startDate)
        var dates: [String] = []
        let endDate = Date(timeIntervalSince1970: endDate)

        while currentDate <= endDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd"
            let dateString = dateFormatter.string(from: currentDate)
            dates.append(dateString)

            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return dates
    }
}
