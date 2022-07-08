//
//  BrandCollectionViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 29.06.22.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    static let identifier = "BrandCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.brandImageView.image = nil
    }
    
    func setup(_ item: ListItem) {
        if let image = UIImage(named: item.image ?? "") {
            brandImageView.image = image
        }
        brandImageView.contentMode = .scaleAspectFill
        brandNameLabel.text = item.title
    }
    
    func setupCell(brand: BrandContent) {
        self.brandImageView.image = UIImage(named: "image1")
        self.brandImageView.contentMode = .scaleAspectFill
        self.brandNameLabel.text = brand.name
    }
    
    @IBAction func favoritesAction(_ sender: Any) {
        
        
    }
    

}
