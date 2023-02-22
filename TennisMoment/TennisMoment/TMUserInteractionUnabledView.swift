//
//  recordView.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/11.
//

import Foundation
import UIKit
import TMComponent

class TMUserInteractionUnabledView: TMView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        let tmview = view as? TMUserInteractionUnabledView
        
        if tmview?.toggle == false {
            return tmview
        }else {
            if tmview == self {
                return nil
            }
            return view
        }
    }
    
}
//            if tmview == nil {
//                for childView in view!.subviews {
//                    let point = self.convert(point, to: childView)
//                if childView.point(inside: point, with: event) {
//                        return view
//                    }else {
//                        return nil
//                    }
//                }
//                return nil
//            }else {
//                return nil
//            }
