//
//  MapForecastView.swift
//  News&Forecast
//
//  Created by Marat Tazhetdinov on 03.11.2021.
//

import UIKit
import GoogleMaps
import MapKit
import RxSwift

import CoreLocation

class MapForecastView: UIViewController {

    @IBOutlet weak var appleMapView: MKMapView!
    
    var googleMapView: GMSMapView!
    var presenter: MapForecastPresenterProtocol!
    var marker: GMSMarker?
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000000
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLocationServices()
        addAppleMapGesture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google Maps
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        googleMapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        googleMapView.delegate = self
        googleMapView.isMyLocationEnabled = true
        self.view.addSubview(googleMapView)
        
        setupRC()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupRC() {
        if RCManager.shared.getBoolValues(from: .appleMap) {
            googleMapView.isHidden = true
            appleMapView.isHidden = false
        }
    }
    
    func addAppleMapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(appleMapViewTap(sender:)))
        gestureRecognizer.numberOfTapsRequired = 1
        appleMapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            appleMapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            showSettingsAlert()
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            appleMapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            showSettingsAlert()
        default: break
        }
    }
    
    
    func showSettingsAlert() {
        let alert = UIAlertController(title: nil, message: "Your have to allow use location in settings", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setting = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(setting)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func appleMapViewTap(sender: UITapGestureRecognizer) {
        let point = sender.location(in: appleMapView)
        let coordinate = appleMapView.convert(point, toCoordinateFrom: appleMapView)
        self.presenter.setCoordinate(coordinate)
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension MapForecastView: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.presenter.setCoordinate(coordinate)
        
    }
}

extension MapForecastView: MKMapViewDelegate {
}

extension MapForecastView: MapForecastViewProtocol {
    
    func setWeatherData(_ data: String, coordinate: CLLocationCoordinate2D) {
        marker?.map = nil
        marker = GMSMarker(position: coordinate)
        marker?.title = data
        marker?.map = googleMapView
        googleMapView.selectedMarker = marker
        
        
        appleMapView.removeAnnotations(appleMapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = data
        appleMapView.addAnnotation(annotation)
        presenter.updateData()
    }
        
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MapForecastView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if appleMapView.annotations.count == 0 {
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            appleMapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

