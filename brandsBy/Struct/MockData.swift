//
//  MockData.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import Foundation
struct MockData {
    static let pageData: [ListSection] = {
        return [ListSection.categories(globalCategories.map({ .init(title: $0, image: nil)})), content]
    }()
    
//    повторно не читается, причина не ясна
    static var categories: ListSection = {
        return ListSection.categories(globalCategories.map({ .init(title: $0, image: nil)})) 
    }()

    static var content: ListSection = {
        .content([ListItem]())
    }()
    
    
}
