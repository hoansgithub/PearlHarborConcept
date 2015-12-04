//
//  PhysicsCategories.swift
//  TrigBlasterPractice
//
//  Created by Admin on 10/27/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import Foundation
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let motherShipCategory   : UInt32 = 0b1
    static let baseBulletCategory: UInt32 = 0b10
    static let enemyCategory: UInt32 = 0b100
    static let aeroliteCategory: UInt32 = 0b1000
}