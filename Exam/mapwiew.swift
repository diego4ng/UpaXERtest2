//
//  mapwiew.swift
//  Exam
//
//  Created by Diego Fernandez on 2/7/19.
//  Copyright © 2019 Diegofernandez. All rights reserved.
//

import Foundation


import UIKit
import MapKit
import CoreLocation

class mapview: UIViewController,UISearchBarDelegate,CLLocationManagerDelegate{
    
//    @IBOutlet var searchbar: UISearchBar!
//    @IBOutlet var mapita: MKMapView!
//    @IBOutlet var coordenadalabel: UILabel!
    
    @IBOutlet var mapita: MKMapView!
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var coordenadalabel: UILabel!
    
    var manager = CLLocationManager()
    var latitud : CLLocationDegrees!
    var longitud : CLLocationDegrees!
    
    var latitudpropia : CLLocationDegrees!
    var longitudpropia : CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapita.setRegion(coordinateRegion, animated: true)
        }
        
    }
    
    
    @IBAction func obtenercoordenadas(_ sender: UIButton) {
        coordenadalabel.text = "lat: \(latitud!)  & long: \(longitud!)"
        let localizacion = CLLocationCoordinate2DMake(latitud, longitud)
        let span = MKCoordinateSpan(latitudeDelta: 0.00110, longitudeDelta: 0.010)
        let region = MKCoordinateRegion(center: localizacion, span: span)
        self.mapita.setRegion(region, animated: true)
        self.mapita.showsUserLocation = true
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            self.latitud = location.coordinate.latitude
            self.longitud = location.coordinate.longitude
            
            
        }
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder() // ocualta el buscador
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchbar.text!) { (places:[CLPlacemark]?, error:Error?) in
            if error == nil {
                
                let place = places?.first
                let anotacion = MKPointAnnotation()
                anotacion.coordinate = ((place?.location?.coordinate))!
                anotacion.title = self.searchbar.text
                
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                self.mapita.setRegion(region, animated: true)
                
                self.mapita.addAnnotation(anotacion)
                self.mapita.selectAnnotation(anotacion, animated: true)
                
                
            } else {
                print ("hubo un error")
            }
            
        }
    }
    
}




extension mapview: MKMapViewDelegate
{
    
}
