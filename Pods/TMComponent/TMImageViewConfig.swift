//
//  TMImageViewConfig.swift
//  TMComponent
//
//  Created by Jason Zhang on 2023/3/21.
//

import Foundation
import UIKit

open class TMImageViewConfig {
    var image: String
    var contentMode: UIView.ContentMode
    public init(image: String, contentMode: UIView.ContentMode) {
        self.image = image
        self.contentMode = contentMode
    }
}
