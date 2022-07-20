//
//  UIViewController+Extension.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import UIKit
import Foundation

extension UIViewController {
    class func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}
