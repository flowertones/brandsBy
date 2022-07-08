//
//  BrandCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 24.06.22.
//

import UIKit

class BrandCell: UICollectionViewCell {

    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandImageView: UIImageView!
//    var brandContent: BrandContent?
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.brandImageView.image = nil
    }
    
    func setupCell(brand: BrandContent) {
        self.brandImageView.image = UIImage(named: "image1")
        self.brandImageView.contentMode = .scaleAspectFill
        self.brandNameLabel.text = "brand.name"
    }
    
}
