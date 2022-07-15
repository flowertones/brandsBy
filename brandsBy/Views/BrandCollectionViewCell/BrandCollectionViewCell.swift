//
//  BrandCollectionViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 29.06.22.
//

import UIKit
import SDWebImage

class BrandCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    static let identifier = "BrandCollectionViewCell"
    var favorites = RealmContent()
    var deleteThisCell: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
//        if DefaultsManager.favorites {
//            self.favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//        
//        if DefaultsManager.notFavorites {
//            self.favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
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
        brandImageView.sd_setImage(with: URL(string: brand.image))
        brandImageView.contentMode = .scaleAspectFill
        brandNameLabel.text = brand.name
    }
    
    func setupFavoriteCell(brand: RealmContent) {
//        brandImageView.sd_setImage(with: URL(string: brand.image))
        brandImageView.contentMode = .scaleAspectFill
        brandNameLabel.text = brand.name
    }
    
    @IBAction func favoritesAction(_ sender: Any) {
        if favoritesButton.tag == 0 {
            favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            DefaultsManager.favorites = true
            DefaultsManager.notFavorites = false
            favoritesButton.tintColor = .black
            favoritesButton.tag = 1
            let brandToSave = RealmContent()
            brandToSave.name = brandNameLabel.text ?? ""
//            brandToSave.image = brandImageView.image
            RealmManager.save(object: brandToSave)
            print(brandToSave.name)
            

        } else {
            favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            DefaultsManager.favorites = false
            DefaultsManager.notFavorites = true
            favoritesButton.tintColor = .black
            favoritesButton.tag = 0
            deleteThisCell?()
//             RealmManager.delete(object: self.favorites)
//             self.favorites = RealmManager.read()
        }
        
    }
    

}
