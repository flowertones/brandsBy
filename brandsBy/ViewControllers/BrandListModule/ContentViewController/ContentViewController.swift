//
//  ContentViewController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import UIKit

class ContentViewController: UIViewController {

//    static let identifier = "ContentViewController"
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "image2")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.text = "SKZK.STORE"
        return nameLabel
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        setupViewsConstraints()
    }




}

extension ContentViewController {
    
    private func setupViewsConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        NSLayoutConstraint.activate( [
            nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor , constant: 70),
            nameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
}
