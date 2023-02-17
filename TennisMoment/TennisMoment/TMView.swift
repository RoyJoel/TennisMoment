//
//  TMConfig.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2022/12/28.
//

import Foundation
import UIKit

class TMView: UIView {
    var originalBounds: CGRect = CGRect()
    
    var originalPoint: CGPoint = CGPoint()
    
    var newBounds: CGRect = CGRect()
    
    var newPoint: CGPoint = CGPoint()
    
    var scaleTimes: CGFloat = CGFloat()
    
    var duration: CFTimeInterval = 0
    
    var toggle: Bool = false
    
    func setup(_ originalBounds: CGRect, _ originalPoint: CGPoint, _ newBounds: CGRect, _ newPoint: CGPoint, _ duration: CFTimeInterval) {
        self.originalBounds = originalBounds
        self.originalPoint = originalPoint
        self.newBounds = newBounds
        self.newPoint = newPoint
        self.duration = duration
    }
    
    func scaleTo(_ isEnlarge: Bool) {
        if !isEnlarge {
            self.toggle.toggle()
            addAnimation(self.originalPoint, self.newPoint, self.duration, "position")
            addAnimation(self.originalBounds, self.newBounds, self.duration, "bounds")
            self.bounds = self.newBounds
            self.layer.position = newPoint
        } else {
            self.toggle.toggle()
            addAnimation(self.newBounds, self.originalBounds, self.duration, "bounds")
            addAnimation(self.newPoint, self.originalPoint, self.duration, "position")
            self.bounds = self.originalBounds
            self.layer.position = self.originalPoint
        }
    }
    
    func addGroupAnimation(with views: [UIView], isEnlarge: Bool) {
        let widthRatio = self.newBounds.width / self.originalBounds.width
        let heightRatio = self.newBounds.height / self.originalBounds.height
        let xDistance = self.newPoint.x - self.originalPoint.x
        let yDistance = self.newPoint.y - self.originalPoint.y
        
        if isEnlarge {
            for view in views {
                view.addAnimation(view.layer.position, CGPoint(x: view.layer.position.x + xDistance, y: view.layer.position.y + yDistance), self.duration, "position")
                view.addAnimation(view.bounds, CGRect(x: 0, y: 0, width: view.bounds.width * widthRatio, height: view.bounds.height * widthRatio), self.duration, "bounds")
//                print(view.layer.position)
//                print(xDistance,yDistance)
//                print(CGPoint(x: view.layer.position.x + xDistance, y: view.layer.position.y + yDistance))
                
            }
        }else {
            for view in views {
                view.addAnimation(CGPoint(x: view.layer.position.x + xDistance, y: view.layer.position.y + yDistance), view.layer.position, self.duration, "position")
                view.addAnimation(CGRect(x: 0, y: 0, width: view.bounds.width * widthRatio, height: view.bounds.height * widthRatio), view.bounds, self.duration, "bounds")
            }
        }
    }
    
}
