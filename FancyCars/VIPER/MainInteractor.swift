//
//  MainInteractor.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-07.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import RxSwift
import Unbox

class MainInteractor {
    func loadCars() -> Observable<[Car]> {
        let carsApi = CarsApi()
        var result: Observable<String>
        if Reachability.isConnectedToNetwork() {
            result = carsApi.get().asObservable()
        } else {
            result = Observable.just(ApiCache().get(key: carsApi.url))
        }
        
        return result
            .map({json in
                let data = json.data(using: .utf8)
                if let data = data, let cars: [Car] = try? unbox(data: data) {
                    return cars
                } else {
                    return []
                }})

    }
    func getCarAvailable(id: Int) -> Single<Availability> {
        return AvailabilityApi().get(id: id)
            .map({json in
                let data = json.data(using: .utf8)
                if let data = data, let availability: Availability = try? unbox(data: data) {
                    return availability
                } else {
                    throw ApiError.parseError
                }})
    }
}
