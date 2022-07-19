//
//  BrandHeaderView.swift
//  brandsBy
//
//  Created by Alina Karpovich on 28.06.22.
//

import UIKit

class BrandHeaderView: UICollectionReusableView {
    
    static let identifier = "BrandHeaderView"
    
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "headerImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        addSubview(headerImageView)
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        headerImageView.frame = bounds
    }
}
