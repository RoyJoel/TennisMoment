//
//  TMNetWork.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/28.
//

import Alamofire
import Foundation
import SwiftyJSON
class TMNetWork {
    static func get(_ parameters: String, completionHandler: @escaping (JSON?) -> Void) {
        AF.request(URL(string: "http://202.117.128.112:8888" + parameters)!).response { response in
            guard let jsonData = response.data else {
                completionHandler(nil)
                return
            }
            let json = try! JSON(data: jsonData)
            completionHandler(json["data"])
        }
    }

    static func post(_ URLParameters: String, dataParameters: Parameters, completionHandler: @escaping (JSON?) -> Void) {
        AF.request(URL(string: "http://202.117.128.112:8080" + URLParameters)!, method: .post, parameters: dataParameters, encoding: JSONEncoding.default).response { response in
            guard let jsonData = response.data else {
                completionHandler(nil)
                return
            }
            let json = try! JSON(data: jsonData)
            completionHandler(json["data"])
        }
    }
}
