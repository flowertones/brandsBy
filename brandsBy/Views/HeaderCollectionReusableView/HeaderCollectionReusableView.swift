//
//  HeaderCollectionReusableView.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(_ image: UIImage) {
        headerImageView.image = UIImage(named: "image2")
    }
}
