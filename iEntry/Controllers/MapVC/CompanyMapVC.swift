//
//  CompanyMapVC.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import UIKit
import GooglePlaces
import GoogleMaps
import CoreLocation
class CompanyMapVC: UIViewController {
    
    //MARK:- here are the iboutlet
    @IBOutlet weak var lblmaptitle: UILabel!
    @IBOutlet weak var MapView: GMSMapView!
    
    @IBOutlet weak var lbladdressDetail: UILabel!
    @IBOutlet weak var lbladdresstitle: UILabel!
    @IBOutlet weak var lblcompnyDetail: UILabel!
    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var overMApHeight: NSLayoutConstraint!
    @IBOutlet weak var OverMapView: UIView!
    
    var lat = 0.0
    var long = 0.0
    var companyname = ""
    var address = ""
    
    
    //MARK:- here are the Location Manager
    var location = LocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(OverMapView)
        navigationBarHidShow(isTrue: true)
        OverMapView.roundViewWithCustomRadius(radius: 8)
        //self.lblcompnyDetail.text  = ShareData.shareInfo.obj?.company?.name
        //self.lbladdressDetail.text  = ShareData.shareInfo.obj?.company?.address
        
        self.lblcompnyDetail.text = companyname
        self.lbladdressDetail.text = address
        
        
        self.lblmaptitle.text = "M A P A".localized
        self.lblcompany.text = "COMPAÑIA".localized
        self.lbladdresstitle.text = "DIRECCIÓN".localized
        
        conFigMap()
        
        
    }
    
    //MARK:- this funtion use to set the UI
    func conFigMap(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.animateView))

        OverMapView.addGestureRecognizer(tap)

        OverMapView.isUserInteractionEnabled = true
        location.requestForLocation()
//        LocationManager.share.passLatLong = { lat , long  in
//
//            let camera = GMSCameraPosition.camera(withLatitude:31.535321704263147, longitude: 74.38035673619484, zoom: 6.0)
//                let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//            self.MapView = mapView
//            //31.535321704263147, 74.38035673619484
//                // Creates a marker in the center of the map.
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: 31.535321704263147, longitude: 74.38035673619484)
//                marker.title = "Sydney"
//                marker.snippet = "Australia"
//                marker.map = mapView
//        }
        //hareData.shareInfo.obj?.company?.latitud ?? 0.0
        let camera = GMSCameraPosition.camera(withLatitude:lat, longitude: long,zoom: 6.0)

        self.MapView.isMyLocationEnabled = true
        self.MapView.camera = camera
        //31.535321704263147, 74.38035673619484
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:0.0, longitude:0.0)
            //marker.title = "Punjab"
            //marker.snippet = "Lahore"
            marker.map = MapView
       
        
    }
    
    //MARK:- over mapview animate
    
    @objc func animateView() {
        
        if overMApHeight.constant == 50 {
            
            
            overMApHeight.priority = UILayoutPriority(rawValue: 250)
            UIView.animate(withDuration: 0.25, animations: {
                self.overMApHeight.constant = 150
                self.lblcompany.isHidden = false
                self.lblcompnyDetail.isHidden = false
                self.lbladdresstitle.isHidden = false
                self.lbladdressDetail.isHidden = false
                self.view.layoutIfNeeded()
            }, completion: { _ in


            })
        } else if overMApHeight.constant == 150 {
            
            overMApHeight.priority = UILayoutPriority(rawValue: 250)
            UIView.animate(withDuration: 0.25, animations: {
                self.overMApHeight.constant = 50
                self.lblcompany.isHidden = true
                self.lblcompnyDetail.isHidden = true
                self.lbladdresstitle.isHidden = true
                self.lbladdressDetail.isHidden = true
                self.view.layoutIfNeeded()
            }, completion: { _ in

                
            })
        }

        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
