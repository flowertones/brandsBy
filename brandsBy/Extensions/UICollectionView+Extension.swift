//
//  UICollectionView+Extension.swift
//  brandsBy
//
//  Created by Alina Karpovich on 27.06.22.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCellsWith(_ classes: [AnyClass]) {
        for item in classes {
            let nib = UINib(nibName: String(describing: item.self), bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: String(describing: item.self))
        }
    }
}
