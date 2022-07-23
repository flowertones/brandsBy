//
//  BrandCollectionViewCell.swift
//  brandsBy
//
//  Created by Alina Karpovich on 29.06.22.
//
protocol ReloadCell: AnyObject {
    func reloadCell()
}

import UIKit
import SDWebImage

class BrandCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    static let identifier = "BrandCollectionViewCell"
    var favorites = RealmContent()
    var brand: BrandContent?
    var delegate: ReloadCell?
    var deleteThisCell: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.brandImageView.image = nil
    }
    
    func setupCell(brand: BrandContent) {
        if brand.name == "KAZAKI" {
            brandImageView.image = UIImage(named: "image3")
        } else if brand.name == "INKA" {
            brandImageView.image = UIImage(named: "image4")
        } else if brand.name == "tati.clothes" {
            brandImageView.image = UIImage(named: "image2")
        } else {
        brandImageView.sd_setImage(with: URL(string: brand.image))
        }
        brandImageView.contentMode = .scaleAspectFill
        brandNameLabel.text = brand.name
    }
    
    func setupFavoriteCell(brand: RealmContent) {
        let favBrand = globalArrayBrand.first{ $0.name == brand.name}
        guard let image = favBrand?.image else { return }
        if brand.name == "KAZAKI" {
            brandImageView.image = UIImage(named: "image3")
        } else if brand.name == "INKA" {
            brandImageView.image = UIImage(named: "image4")
        } else {
        brandImageView.sd_setImage(with: URL(string: image))
        }
        brandImageView.contentMode = .scaleAspectFill
        brandNameLabel.text = brand.name
    }
    
    @IBAction func favoritesAction(_ sender: Any) {
        guard let name = brandNameLabel.text else { return }
        let brandToSave = RealmContent()
        
        if favoritesButton.tag == 0 {
            favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoritesButton.tintColor = UIColor.darkPeach
            favoritesButton.tag = 1
            brandToSave.name = name
            RealmManager.save(object: brandToSave)
            FavoritesPopUp.showPopup(text: "\(brandToSave.name) добавлен в избранное", duration: 2, useTransparency: false)
            delegate?.reloadCell()
        } else {
            favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoritesButton.tintColor = UIColor.darkPeach
            favoritesButton.tag = 0
            deleteThisCell?()
            FavoritesPopUp.showPopup(text: "\(name) удален из избранного", duration: 2, useTransparency: false)
            self.delegate?.reloadCell()
        }
    }
}
