//
//  ViewController.swift
//  MapPixelApp
//
//  Created by Teja PV on 6/6/18.
//  Copyright © 2018 Teja PV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var pullUpViewConstraint: NSLayoutConstraint!
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius : Double = 1000
    var screenSize = UIScreen.main.bounds
    var spinnerView : UIActivityIndicatorView?
    var progressLbl : UILabel?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }
    
    func addSwipe(){
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }
    
    func animateViewUp() {
        pullUpViewConstraint.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateViewDown() {
        pullUpViewConstraint.constant = 0
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addSpinner(){
        spinnerView = UIActivityIndicatorView()
        spinnerView?.center = CGPoint(x: (screenSize.width / 2)  - ((spinnerView?.frame.width)! / 2), y: 150)
        spinnerView?.activityIndicatorViewStyle = .whiteLarge
        spinnerView?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinnerView?.startAnimating()
        pullUpView.addSubview(spinnerView!)
    }
    
    @objc func dropPin(sender : UITapGestureRecognizer) {
        removePins()
        animateViewUp()
        addSwipe()
        addSpinner()
        let touchPoint = sender.location(in: mapView)
        let touchCorrdinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = DropPin(coordinate: touchCorrdinate, identifier: "dropPin")
        mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCorrdinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func removePins() {
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
    }

    @IBAction func centerMap(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse{
            centerMapOnLocation()
        }
    }
}

extension MapVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "dropPin")
        pinAnnotation.tintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func centerMapOnLocation(){
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapVC : CLLocationManagerDelegate{
    func configureLocationServices(){
        if authorizationStatus == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }else{
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnLocation()
    }
}
