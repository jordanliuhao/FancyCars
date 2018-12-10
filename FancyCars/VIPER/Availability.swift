//
//  Availability.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-09.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import Unbox

struct Availability {
    static let inDealership = "In Dealership"
    static let outOfStock = "Out of Stock"
    static let unavailable = "Unavailable"
    
    let available: String
}

extension Availability: Unboxable {
    init(unboxer: Unboxer) throws {
        self.available = try unboxer.unbox(key: "available")
    }
}
