//
//  FilterCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 18.07.22.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    private var filters = Category.allCases

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupFiler(filter: Category) {
        filterLabel.text = filter.text
//        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
//        categoryLabel.layer.borderWidth = 0.7
//        categoryLabel.layer.borderColor = UIColor.darkGray.cgColor
    }
    

    
}
