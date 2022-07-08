//
//  BrandListSection.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import Foundation

enum ListSection {
    case categories([ListItem])
    case content([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .categories(let items),
                .content(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .categories:
            return "Categories"
        case .content:
            return "Brands"
        }
    }
}
