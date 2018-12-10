//
//  CarsApi.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-08.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import RxSwift

class CarsApi {
    static private let response =
        """
[
    {
        "id": 1,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 1",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 2,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 2",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 3,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 3",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 4,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 4",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 5,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 5",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 6,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 6",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 7,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 7",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 8,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 8",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 9,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 9",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    },
    {
        "id": 10,
        "img": "https://static.cargurus.com/images/site/2009/10/07/14/37/pic-2348232855365192808-200x200.jpeg",
        "name": "Fancy Car 10",
        "make": "MyMake",
        "model": "MyModel",
        "year": 2018
    }
]
"""
    let url = "http://fancycars.ca/cars"

    func get() -> Single<String> {
        // api stub
        return Single.just(CarsApi.response)
            .delay(RxTimeInterval(2), scheduler: MainScheduler.instance)
            .do(onSuccess: {response in
                ApiCache().set(key: self.url, value: response)})
    }
}
