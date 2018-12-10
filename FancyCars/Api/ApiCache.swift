//
//  ApiCache.swift
//  FancyCars
//
//  Created by Jordan Liu on 2018-12-09.
//  Copyright © 2018 Jordan Liu. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

class ApiData : Object {
    @objc dynamic var key = ""
    @objc dynamic var value = ""
    
    override static func primaryKey() -> String? {
        return "key"
    }
}

class ApiCache {
    func get(key: String) -> String {
        let realm = try! Realm()
        let data = realm.object(ofType: ApiData.self, forPrimaryKey: key)
        if let data = data {
            return data.value
        } else {
            return "[]"
        }
    }
    
    func set(key: String, value: String) {
        let realm = try! Realm()
        try! realm.write {
            realm.create(ApiData.self, value:["key": key, "value": value], update: true)
        }
    }
}
