//
//  NetworkManager.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import Foundation
import Moya
import Moya_ObjectMapper

class NetworkManager {
    static let provider = MoyaProvider<BrandsAPI>(plugins: [NetworkLoggerPlugin()])
    
    class func getBrand(successBlock: (([BrandContent]) -> ())? , failureBlock: (() -> ())? = nil) {
        provider.request(.getBrand) { result in
            switch result {
                
            case .success(let response):
                guard let result = try? response.mapArray(BrandContent.self)
                else {
                    failureBlock?()
                    return
                }
                print("success")
                successBlock?(result)
            case .failure(_):
                print("no success")
                  failureBlock?()
            }
        }
    }
}
