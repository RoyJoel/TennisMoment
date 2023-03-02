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
    static func get(_ parameters: String, completionHandler: @escaping (JSON?, Error?) -> Void) {
        AF.request(URL(string: "http://localhost:8080" + parameters)!).response { response in
            switch response.result {
            case let .success(json):
                completionHandler(JSON(json ?? JSON()), nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }

    static func post(_ URLParameters: String, dataParameters: Parameters, completionHandler: @escaping (JSON?, Error?) -> Void) {
        AF.request(URL(string: "http://localhost:8080" + URLParameters)!, parameters: dataParameters).response { response in
            switch response.result {
            case let .success(json):
                completionHandler(JSON(json ?? JSON()), nil)
            case let .failure(error):
                completionHandler(nil, error)
            }
        }
    }
}
