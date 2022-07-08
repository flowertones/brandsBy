//
//  CategoriesCollectionViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 29.06.22.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    func setup(_ item: ListItem) {
//        guard let categories = brandContent.categories else { return }
//        for cat in categories {
//        categoryLabel.text = cat
//        }
        categoryLabel.text = item.title
        categoryLabel.layoutIfNeeded()
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
    }
    
    func setupCategory(category: BrandContent) {
        for cat in category.categories {
             self.categoryLabel.text = cat
         }
    }
}