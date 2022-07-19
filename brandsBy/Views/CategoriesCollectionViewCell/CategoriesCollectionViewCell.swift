//
//  CategoriesCollectionViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 29.06.22.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    private var categories = Category.allCases
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCategory(category: Category) {
        categoryLabel.text = category.text
    }
}
