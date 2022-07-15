//
//  ShopsBrandCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 13.07.22.
//

import UIKit

class ShopsContentCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupCell(shop: Shops) {
        cityLabel.text = shop.city
        addressLabel.text = shop.address
        hoursLabel.text = shop.hours
    }
    
}
