//
//  DescriptionBrandCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 13.07.22.
//

import UIKit

class DescriptionContentCell: UITableViewCell {

    @IBOutlet weak var contentDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
