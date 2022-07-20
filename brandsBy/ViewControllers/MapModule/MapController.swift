//
//  MapController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 16.07.22.
//

import UIKit
import GoogleMaps
import SDWebImage

class MapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapButton: UIButton!
    
    private var locationManager: CLLocationManager!
    private var markers = [GMSMarker]()
    private var brandWithShops = [BrandContent]()
    private var shops = [Shops]()
    var brandContent: BrandContent?
    var nameLabelText: String?
    var categoryBrandRealm: [RealmContent] = []



    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "карта"
        mapButton.layer.borderColor = UIColor.darkGray.cgColor
        mapView.isMyLocationEnabled = true
        self.locationManager = CLLocationManager()
        mapView.delegate = self
        for brand in globalArrayBrand {
            if let place = brand.shops {
                shops += place
                brandWithShops.append(brand)
            }
        }
        brandWithShops.forEach({ setupPoints(brand: $0)})
        centered()
    }
    
    @IBAction func myLocationAction(_ sender: Any) {
        guard let myLocation = mapView.myLocation?.coordinate  else { return }
            
        let camera = GMSCameraPosition(latitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        mapView.animate(to: camera)
        print("tap on the button")
    }

    private func setupPoints(brand: BrandContent) {
        markers = []
        mapView.clear()

        for shop in shops {
            let marker = ShopMarker(position: CLLocationCoordinate2D(latitude: shop.latitude! , longitude: shop.longitude!))
            markers.append(marker)
            marker.shop = shop
            marker.snippet = ("\(String(describing: shop.address)) \n \(String(describing: shop.hours))")
            marker.title = brand.name
            marker.map = mapView
            let markerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            markerView.image = UIImage(named: "pinIcon")
            markerView.tintColor = .black
            markerView.backgroundColor = UIColor(named: "lightPeach")?.withAlphaComponent(0.6)
            markerView.layer.borderWidth = 1.4
            markerView.layer.borderColor = UIColor(named: "darkPeach")?.cgColor
            markerView.layer.cornerRadius = self.view.layer.frame.width / 2
            marker.iconView = markerView
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.centeredCamera()
        }
   }
    
    private func centeredCamera() {
            if let firstPos = markers.first?.position {
            var bounds = GMSCoordinateBounds(coordinate: firstPos, coordinate: firstPos)
            for marker in markers {
                bounds = bounds.includingCoordinate(marker.position)
            }
            if let myLoc = mapView.myLocation?.coordinate {
                bounds = bounds.includingCoordinate(myLoc)
            }
            let insets = UIEdgeInsets(top: 60, left: 40, bottom:  30, right: 40)
            let update = GMSCameraUpdate.fit(bounds, with: insets)
            mapView.animate(with: update)
        } else {
            guard let myLoc = mapView.myLocation?.coordinate  else { return }

            let camera = GMSCameraPosition(latitude: myLoc.latitude, longitude: myLoc.longitude, zoom: 14)
            mapView.animate(to: camera)
        }
    }
    
    func centered() {
        guard let myLocation = mapView.myLocation?.coordinate  else { return }
            
        let camera = GMSCameraPosition(latitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 14)
        mapView.animate(to: camera)
    }
}
    
extension MapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.navigationItem.title = marker.title
        guard let brand = brandWithShops.filter({ $0.name == marker.title }).first else { return false }

        guard let marker = marker as? ShopMarker,
              let shop = marker.shop else { return false }
            
        let camera = GMSCameraPosition(latitude: shop.latitude!, longitude: shop.longitude!, zoom: 14)
        mapView.animate(to: camera)
        let popup = MapPopUp(nibName: String(describing: MapPopUp.self), bundle: nil)
        popup.labelTitle = brand.name
        popup.image = brand.image
        popup.city = shop.city!
        popup.address = shop.address!
        popup.workHours = shop.hours!
        popup.modalPresentationStyle = .overFullScreen
        popup.modalTransitionStyle = .crossDissolve
        present(popup, animated: true)
        return true
    }
}

extension MapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], shop: Shops) {
        guard let lat = shop.latitude,
              let long = shop.longitude else { return }
        let locValue = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let marker = GMSMarker(position: locValue)
        marker.map = mapView
    }
}
