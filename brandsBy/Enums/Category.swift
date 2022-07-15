//
//  Category.swift
//  brandsBy
//
//  Created by Alina Karpovich on 12.07.22.
//

import Foundation

enum Category: String, CaseIterable {
    case dresses = "платья"
    case sportswear = "спортивная одежда"
    case underwear = "белье"
    case shoes = "обувь"
    case bags = "сумки"
    case streetStyle = "street style"
    case jackets = "пиджаки"
    case mensBrands = "мужские бренды"
    case outerwear = "верхняя одежда"
    case tshirts = "футболки"
    case jeans = "джинсы"
    case jewerly = "украшения"
    case office = "офис"
    case nightOut = "night out"
    case jersey = "трикотаж"
    case trenchCoats = "тренчи"
    case concept = "concept"
    case casual = "casual"
    
    var text: String {
        switch self {
            
        case .dresses:
            return "платья"
        case .sportswear:
            return "спортивная одежда"
        case .underwear:
            return "белье"
        case .shoes:
            return "обувь"
        case .bags:
            return "сумки"
        case .streetStyle:
            return "street style"
        case .jackets:
            return "пиджаки"
        case .mensBrands:
            return "мужские бренды"
        case .outerwear:
            return "верхняя одежда"
        case .tshirts:
            return "футболки"
        case .jeans:
            return "джинсы"
        case .jewerly:
            return "украшения"
        case .office:
            return "офис"
        case .nightOut:
            return "night out"
        case .jersey:
            return "трикотаж"
        case .trenchCoats:
            return "тренчи"
        case .concept:
            return "concept"
        case .casual:
            return "casual"
        }
    }
}
