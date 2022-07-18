//
//  MapController.swift
//  brandsBy
//
//  Created by Alina Karpovich on 16.07.22.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    private var locationManager: CLLocationManager!
    private var markers = [GMSMarker]()
    private var brandWithShops = [BrandContent]()
    private var shops = [Shops]()
    private var nameShops = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
//        locationManager.delegate = self
        for brand in globalArrayBrand {
            if let place = brand.shops {
                shops += place
                brandWithShops.append(brand)
            }
        }
        
        
        centered()
        setupPoints()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        getShops()
//    }
    
    @IBAction func myLocationAction(_ sender: Any) {
        guard let myLocation = mapView.myLocation?.coordinate  else { return }
            
        let camera = GMSCameraPosition(latitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        mapView.animate(to: camera)
    }
    
//    func getBrandShops() {
//        brandShops = UserDefaults.standard.object(forKey: "brandShops") as! [BrandContent]
//        for brand in brandShops {
//            if let shop = brand.shops {
//                shops += shop
//            }
//        }
//    }
    
//    private func getShops() {
//        for brand in globalArrayBrand {
//            if let place = brand.shops {
//                shops += place
//                brandWithShops.append(brand)
//            }
//
//        }
//    }

   private func setupPoints() {
        markers = []
        mapView.clear()

        for shop in shops {
            let marker = ShopMarker(position: CLLocationCoordinate2D(latitude: shop.latitude! , longitude: shop.longitude!))
            markers.append(marker)
            marker.shop = shop
            for brandWithShop in brandWithShops {
                marker.title = brandWithShop.name
            }
//            marker.title = brand.name
            marker.map = mapView
            let markerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            markerView.image = UIImage(systemName: "camera.macro")
            markerView.tintColor = .black
            marker.iconView = markerView
        }
            self.centeredCamera()
   }
    
    private func centeredCamera() {
            if let firstPos = markers.first?.position {
            var bounds = GMSCoordinateBounds(coordinate: firstPos, coordinate: firstPos)
            for marker in markers {
                marker.title = nameShops.joined(separator: ",")
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
            
        let camera = GMSCameraPosition(latitude: myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        mapView.animate(to: camera)
    }
}
    




extension MapController: GMSMapViewDelegate {
    
}

//extension MapController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], cafe: Shops) {
//        
//        let cafeLocation = CLLocationCoordinate2D(latitude: cafe.latitude!, longitude: cafe.longitude!)
//        let marker = GMSMarker(position: cafeLocation)
//        marker.map = mapView
//    }
//}
