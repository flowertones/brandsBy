//
//  ContentController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import UIKit

class ContentController: UIViewController {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var brandContent: BrandContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func getBrand(brand: BrandContent) {
            nameLabel.text = brand.name
        }
    }


}
