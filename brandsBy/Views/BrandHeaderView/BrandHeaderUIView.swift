//
//  BrandHeaderUIView.swift
//  brandsBy
//
//  Created by Alina Karpovich on 28.06.22.
//

import UIKit

class BrandHeaderUIView: UIView {
    
//    private let searchButton: UIButton = {
//        let button = UIButton()
//        button.imageView?.image = UIImage(systemName: "magnifyingglass")
////        button.layer.borderColor = UIColor.white.cgColor
////        button.layer.borderWidth = 1
////        button.translatesAutoresizingMaskIntoConstraints = false
////        button.layer.cornerRadius = 5
//        return button
//    }()

    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "image2")
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
//        addSubview(searchButton)
//        applyConstraints()
    }
    
//    private func applyConstraints() {
//
//        let searchButtonConstraints = [
//            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
//            searchButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            searchButton.widthAnchor.constraint(equalToConstant: 20)
//        ]
//
//        NSLayoutConstraint.activate(searchButtonConstraints)
//
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    
    
}
