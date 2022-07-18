//
//  RealmManagers.swift
//  brandsBy
//
//  Created by Alina Karpovich on 10.07.22.
//

import Foundation
import RealmSwift

class RealmManager {
    private static let realm = try! Realm ()
    static let shared = RealmManager()
    private init () {}

    static func read() -> [RealmContent] {
        let result = realm.objects(RealmContent.self)
        return Array(result)
    }
    
    static func save(object: RealmContent) {
        try? realm.write {
            realm.add(object)
        }
    }
    
//    class func delete<T: Object>(object: T) {
//        try? realm.write({
//            realm.delete(object)
//        })
//}
    static func deleteFromName(objectName: String) {
        let data = read()
        guard let objectToDelete = data.filter({ $0.name == objectName}).first else { return }
        
        try? realm.write({
            realm.delete(objectToDelete)
        })
    }
    
    static func delete(object: RealmContent) {
        let data = read()
        guard let objectToDelete = data.filter({ $0.name == object.name}).first else { return }
        
        try? realm.write({
            realm.delete(objectToDelete)
        })
    }
}
