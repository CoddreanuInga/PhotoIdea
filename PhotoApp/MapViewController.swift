//
//  MapViewController.swift
//  PhotoApp
//
//  Created by Inga Codreanu on 11/25/15.
//  Copyright © 2015 Inga. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController ,MKMapViewDelegate{

   
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    var latitud :NSNumber!
    var longitudine: NSNumber!
    

    
   
    let searchRadius: CLLocationDistance = 2000
    
    @IBAction func searchOnValueChanged(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
        
        searchInMap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let initialLocation = CLLocation(latitude: (latitud).doubleValue, longitude: (longitudine).doubleValue)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        searchInMap()
    }
    
    func searchInMap() {
         let initialLocation = CLLocation(latitude: (latitud).doubleValue, longitude: (longitudine).doubleValue)
        // 1
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex)
        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        // 3
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler {
            (response, error) in
            
            for item in response!.mapItems {
                self.addPinToMapView(item.name!, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
        }
    }
    
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: (latitud).doubleValue, longitude: (longitudine).doubleValue)
        let annotation = MyAnnotation(coordinate: location, title: title)
        
        mapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}