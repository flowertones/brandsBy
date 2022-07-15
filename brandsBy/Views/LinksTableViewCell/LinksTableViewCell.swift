//
//  LinksTableViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 11.07.22.
//

import UIKit

class LinksTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var linksLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
