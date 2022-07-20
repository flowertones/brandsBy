//
//  ContentBrandCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 13.07.22.
//

import UIKit
import SDWebImage

class ProfileContentCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setupCell(brand: BrandContent) {
        if brand.name == "KAZAKI" {
            contentImageView.image = UIImage(named: "image3")
        } else if brand.name == "INKA" {
            contentImageView.image = UIImage(named: "image4")
        } else {
        self.contentImageView.sd_setImage(with: URL(string: brand.image))
        }
        self.contentImageView.contentMode = .scaleAspectFill
        self.contentNameLabel.text = brand.name
    }  
}
