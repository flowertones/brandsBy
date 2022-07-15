//
//  ContentController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import UIKit

class ContentController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var brandContent: BrandContent?
    private var contentPoints = ContentPoints.allCases
    private var links: [String] = []
    private var iconLinks: [UIImage] = []
    private var shops: [Shops] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        registerCells()
        createContent()
        setupNavigationButton()
        self.tableView.separatorStyle = .none
    }
    
    private func createContent() {
        guard let brandContent = brandContent
        else { return }
        if let inst = brandContent.instagram, brandContent.instagram != "" {
        let inst = "https://www.instagram.com/\(inst)/"
        links.append(inst)
        iconLinks.append(UIImage(named: "instIcon")!)
        }
        if let tg = brandContent.tg, brandContent.tg != "" {
            links.append("https://t.me/\(tg)")
            iconLinks.append(UIImage(systemName: "paperplane")!)
        }
        if let site = brandContent.website, brandContent.website != "" {
            links.append(site)
            iconLinks.append(UIImage(named: "siteIcon")!)
        }
        guard let shop = brandContent.shops else { return }
        shops = shop
    }
    
    private func registerCells() {
        
        tableView.register(UINib(nibName: String(describing: ProfileContentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileContentCell.self))
        tableView.register(UINib(nibName: String(describing: DescriptionContentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DescriptionContentCell.self))
        tableView.register(UINib(nibName: String(describing: LinksTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LinksTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: ShopsContentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ShopsContentCell.self))
    }
    
    private func setupNavigationButton() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            topItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
        }
    }

}

extension ContentController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentPoints.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch contentPoints[section] {
            
        case .profile:
            return 1
        case .descrip:
            return 1
        case .links:
            return links.count
        case .shops:
            return shops.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch contentPoints[section] {
            
        case .descrip:
                return "ОПИСАНИЕ"
        case .links:
                return "ССЫЛКИ"
        case .shops:
                return "АДРЕС МАГАЗИНА"
        default:
            return ""
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch contentPoints[indexPath.section] {

        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileContentCell.self), for: indexPath)
            guard let profileCell = cell as? ProfileContentCell else { return cell }
            profileCell.setupCell(brand: brandContent!)
            return profileCell
            
        case .descrip:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DescriptionContentCell.self), for: indexPath)
            guard let descriptionCell = cell as? DescriptionContentCell else { return cell }
            descriptionCell.contentDescriptionLabel.text = brandContent?.description
            return descriptionCell
            
        case .links:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LinksTableViewCell.self), for: indexPath)
            guard let linksCell = cell as? LinksTableViewCell else { return cell }
            linksCell.linksLabel.text = links[indexPath.row]
            linksCell.imageViewCell.image = iconLinks[indexPath.row]
            return linksCell
            
        case .shops:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShopsContentCell.self), for: indexPath)
            guard let shopsCell = cell as? ShopsContentCell else { return cell }
            shopsCell.setupCell(shop: shops[indexPath.row])
            return shopsCell
        }
    }
    
    
}
