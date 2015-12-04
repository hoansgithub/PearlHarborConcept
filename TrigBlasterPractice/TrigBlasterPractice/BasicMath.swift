//
//  BasicMath.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import UIKit

//VECT
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
    static func getLength(left: CGPoint, right: CGPoint) -> CGFloat {
        let offset = left - right
        return offset.length()
    }
}


class BasicMath {

    
    
    static func degreesToRadians(degrees:CGFloat) -> CGFloat {
        return CGFloat(degrees) * CGFloat(M_PI) / 180.0
    }
    
    static func radiansToDegrees(angle:CGFloat) -> CGFloat {
        return CGFloat(angle) *   CGFloat(180 / M_PI)
    }
    
    static func randomNumberInRange(min:UInt32 , max:UInt32) -> UInt32 {
        return arc4random_uniform(max - min) + min
    }

    
}