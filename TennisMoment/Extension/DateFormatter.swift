//
//  DateFormatter.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/19.
//

import Foundation

extension TimeInterval {
    func convertToString(formatterString: String) -> String {
        let formatter = DateFormatter()
        let date = Date(timeIntervalSince1970: self)
        formatter.dateFormat = formatterString
        let dateString = formatter.string(from: date)
        return dateString
    }
}
