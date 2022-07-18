//
//  RealmContent.swift
//  brandsBy
//
//  Created by Alina Karpovich on 10.07.22.
//

import Foundation
import RealmSwift
import UIKit

@objc final class RealmContent: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
//    @objc dynamic var image: UIImage?
//    @objc dynamic var descrip: String?
//    @objc dynamic var instagram: String?
//    @objc dynamic var website: String?
//    @objc dynamic var tg: String?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
//    @objc dynamic var image: UIImage?
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
}

