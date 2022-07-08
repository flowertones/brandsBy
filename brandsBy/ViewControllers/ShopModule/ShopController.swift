//
//  ShopController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.06.22.
//

import UIKit

class ShopController: UIViewController {

    @IBOutlet weak var shopImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        shopImageView.image =  UIImage(named: "shopImage")
        shopImageView.contentMode = .scaleAspectFill

        
    }




}
