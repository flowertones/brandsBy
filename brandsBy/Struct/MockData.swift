//
//  MockData.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import Foundation
struct MockData {
    static var pageData: [ListSection] = [categories, content]
    
    static var categories: ListSection = {
        global
    }()

    static var content: ListSection = {
        .content([ListItem]())
    }()
    
    
}
