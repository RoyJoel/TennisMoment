//
//  TMViewDelegate.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/8.
//

import Foundation

protocol TMViewdelegate: NSObjectProtocol {
    var originalBounds: CGRect { get set }
    var originalPoint: CGPoint { get set }
    var newBounds: CGRect { get set }
    var newPoint: CGPoint { get set }
    var duration: CFTimeInterval { get set }
    var toggle: Bool { get }
    func scaleTo(_ toggle: Bool)
}
