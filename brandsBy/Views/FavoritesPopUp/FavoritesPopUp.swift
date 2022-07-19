//
//  FavoritesPopUp.swift
//  brandsBy
//
//  Created by Alina Karpovich on 19.07.22.
//

import UIKit

class FavoritesPopUp: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    var text = "удален из избранного"
    var duration: TimeInterval = 3.0
    var useTransparency = false
    private var timer: Timer?
    
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
        statusLabel.text = self.text
    }
    
    @objc private func close() {
        if useTransparency {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.statusLabel.alpha = 0
            } completion: { [weak self] isFinished in
                self?.dismiss(animated: true)
            }

        } else {
            self.dismiss(animated: true)
        }
    }

    static func showPopup(text: String = "удален из избранного", duration: TimeInterval = 3, useTransparency: Bool = false) {
        let popup = FavoritesPopUp(nibName: FavoritesPopUp.id, bundle: nil)
        popup.text = text
        popup.duration = duration
        popup.useTransparency = useTransparency
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overCurrentContext
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(popup, animated: true, completion: nil)
        }
    }
    
}
