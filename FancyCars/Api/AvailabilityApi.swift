//
//  AvailabilityApi.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-08.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import RxSwift

class AvailabilityApi {
    static private let responses = [
"""
{
"available": "In Dealership"
}
""",
"""
{
"available": "Out of Stock"
}
""",
"""
{
"available": "Unavailable"
}
"""
    ]
    
    func get(id: Int) -> Single<String> {
        // api stub
        if Reachability.isConnectedToNetwork() {
            let fakeVisibleValue = AvailabilityApi.responses[id % AvailabilityApi.responses.count]
            return Single.just(fakeVisibleValue)
                .delay(RxTimeInterval(2), scheduler: MainScheduler.instance)
        } else {
            return Single<String>.error(ApiError.networkError)
        }
    }
}
