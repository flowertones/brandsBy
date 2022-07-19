//
//  FiltersViewController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 18.07.22.
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let filters = Category.allCases
    var brandArray = [BrandContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        registerCells()
        setupNavigationButton()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: String(describing: FilterCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FilterCell.self))
    }
    
    private func setupNavigationButton() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}

extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterCell.self), for: indexPath) as! FilterCell
        cell.setupFiler(filter: filters[indexPath.row])
//            categoryCell.categoryLabel.layer.cornerRadius = categoryCell.categoryLabel.frame.height / 2
//            categoryCell.categoryLabel.layer.borderWidth = 0.6
//            categoryCell.categoryLabel.layer.borderColor = UIColor.darkGray.cgColor
        return cell
    }
}

extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func categoryFilter(brand: BrandContent ) -> Bool {
            var result = false
            for cat in brand.categories {
                if cat == filters[indexPath.row].rawValue {
                result = true
                }
            }
            return result
        }
        
        let categoryBrand = brandArray.filter(categoryFilter)
    
        let categoryVC = CategoryViewController(nibName: String(describing: CategoryViewController.self), bundle: nil)
        categoryVC.categoryBrand = categoryBrand
        categoryVC.title = "\(filters[indexPath.row].rawValue)"
        navigationController?.pushViewController(categoryVC, animated: true)
    }
}
