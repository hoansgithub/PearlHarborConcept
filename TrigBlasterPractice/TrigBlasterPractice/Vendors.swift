//
//  Vendors.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import UIKit
class Vendors {
    static func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}