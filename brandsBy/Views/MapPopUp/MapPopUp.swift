//
//  MapPopUp.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.07.22.
//

import UIKit

class MapPopUp: UIViewController {

    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var workHoursLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    var labelTitle = " "
    var image = ""
    var city = ""
    var address = ""
    var workHours = ""
    var duration: TimeInterval = 3.0
    private var timer: Timer?
    var useTransparency = false

    static let id = String(describing: FavoritesPopUp.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTimer()
    }
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: self.duration, repeats: false, block: { [weak self] _ in
            self?.close()
        })
    }
    
    private func setupPopup() {
        self.viewPopUp.backgroundColor = UIColor.lightPeach.withAlphaComponent(0.8)
        self.viewPopUp.layer.cornerRadius = 3
        self.viewPopUp.layer.shadowRadius = 6
        self.viewPopUp.layer.shadowColor = UIColor.darkPeach.cgColor
        self.viewPopUp.layer.shadowOpacity = 3
        imageView.contentMode = .scaleAspectFill
        nameLabel.text = self.labelTitle
        imageView.sd_setImage(with: URL(string: self.image))
        cityLabel.text = self.city
        addressLabel.text = self.address
        workHoursLabel.text = self.workHours
        
    }
    
    @objc private func close() {
        if useTransparency {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.nameLabel.alpha = 0
            } completion: { [weak self] isFinished in
                self?.dismiss(animated: true)
            }
        } else {
            self.dismiss(animated: true)
        }
    }

    static func showPopup(labelTitle: String = "", image: String = "", city: String = "", address: String = "", workHours: String = "", duration: TimeInterval = 3, useTransparency: Bool = false) {
        let popup = MapPopUp(nibName: MapPopUp.id, bundle: nil)
        popup.labelTitle = labelTitle
        popup.image = image
        popup.city = city
        popup.address = address
        popup.workHours = workHours
        popup.duration = duration
        popup.useTransparency = useTransparency
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overCurrentContext
    }
}
