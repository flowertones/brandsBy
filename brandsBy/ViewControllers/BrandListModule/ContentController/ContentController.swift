//
//  ContentController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 4.07.22.
//

import UIKit

class ContentController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    var brandContent: BrandContent?
    private var contentPoints = ContentPoints.allCases
    private var links: [String] = []
    private var textLinks: [String] = []
    private var iconLinks: [UIImage] = []
    private var shops: [Shops] = []
    var deleteThisCell: (() -> Void)?
    var isFavorite = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.topViewController?.title = brandContent?.name
        tableView.dataSource = self
        registerCells()
        createContent()
        setupNavigationButton()
        self.tableView.separatorStyle = .none
        
        if isFavorite {
            favoritesButton.setTitle("УБРАТЬ ИЗ ИЗБРАННОГО", for: .normal)
        }
        
        favoritesButton.tintColor = .black
        favoritesButton.layer.opacity = 0.7
        favoritesButton.layer.cornerRadius = 0
    }
    
    private func createContent() {
        guard let brandContent = brandContent
        else { return }
        if let inst = brandContent.instagram, brandContent.instagram != "" {
        let inst = "https://www.instagram.com/\(inst)/"
        links.append(inst)
        iconLinks.append(UIImage(named: "instIcon")!)
            textLinks.append("instagram")
        }
        if let tg = brandContent.tg, brandContent.tg != "" {
            links.append("https://t.me/\(tg)")
            iconLinks.append(UIImage(named: "tgIcon")!)
            textLinks.append("telegram")
        }
        if let site = brandContent.website, brandContent.website != "" {
            links.append(site)
            iconLinks.append(UIImage(named: "siteIcon")!)
            textLinks.append("website")
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
            topItem.backBarButtonItem?.tintColor = .black
        }
    }
    
    @IBAction func favoritesAction(_ sender: Any) {
        guard let name = brandContent?.name else { return }
        let brandToSave = RealmContent()
        
        if isFavorite == false {
            favoritesButton.setTitle("УБРАТЬ ИЗ ИЗБРАННОГО", for: .normal)
            isFavorite = true
            brandToSave.name = name
            RealmManager.save(object: brandToSave)
            FavoritesPopUp.showPopup(text: "\(brandToSave.name) добавлен в избранное", duration: 2, useTransparency: false)
        } else {
            favoritesButton.setTitle("ДОБАВИТЬ В ИЗБРАННОЕ", for: .normal)
            isFavorite = false
            RealmManager.deleteFromName(objectName: name)
            deleteThisCell?()
            FavoritesPopUp.showPopup(text: "\(name) удален из избранного", duration: 2, useTransparency: false)
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        guard let brandContent = brandContent else {
            return
        }
        
        let alert = UIAlertController()
        
        let asText = UIAlertAction(title: "Поделиться", style: .default) { [weak self] _ in
            var text = "Посмотри белорусский бренд \(brandContent.name)\n\n"
            
            text += "Ссылки: \n https://www.instagram.com/\(brandContent.instagram!)/"
            
            if brandContent.tg != "" {
                text += "\n https://t.me/\(brandContent.tg!)"
            }
            if brandContent.website != "" {
                text += "\n \(brandContent.website!)"
            }
            if let shops = brandContent.shops {
                for shop in shops {
                    text += "\n \(shop.city!) \n \(shop.address!) \n \(shop.hours!)"
                }
            }
            
            text += "\n Скачивай приложение brandsBy, чтобы узнавать о новых белорусских брендах"

            let textToShare = [text]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self?.view
            
            self?.present(activityViewController, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alert.addAction(asText)
        alert.addAction(cancel)
        self.present(alert, animated: true)
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
            return nil
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
            let huperLinks: [String : String] = [textLinks[indexPath.row] : links[indexPath.row]]
            linksCell.textView.addHyperLinksToText(originalText: textLinks[indexPath.row], hyperLinks: huperLinks)
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
