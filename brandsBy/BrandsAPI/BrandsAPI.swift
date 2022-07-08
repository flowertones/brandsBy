//
//  BrandsAPI.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import Foundation
//https://remontfar.by/bransList.json?

import Moya

enum BrandsAPI {
    case getBrand
}

extension BrandsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://remontfar.by/")!
    }
    
    var path: String {
        switch self {
        case .getBrand:
            return "bransList.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBrand:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
            return .requestPlain
    
    }
    
    var headers: [String : String]? {
        return nil
    }
}
