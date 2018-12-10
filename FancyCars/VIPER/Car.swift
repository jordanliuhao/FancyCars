//
//  Car.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-08.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import Unbox

struct Car {
    let id: Int
    let img: String
    let name: String
    let make: String
    let model: String
    let year: String
}

extension Car: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.img = try unboxer.unbox(key: "img")
        self.name = try unboxer.unbox(key: "name")
        self.make = try unboxer.unbox(key: "make")
        self.model = try unboxer.unbox(key: "model")
        self.year = try unboxer.unbox(key: "year")
    }
}
