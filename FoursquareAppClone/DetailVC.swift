//
//  DetailVC.swift
//  FoursquareAppClone
//
//  Created by Metehan Canpolat on 23.03.2024.
//

import UIKit
import MapKit
import ParseUI

class DetailVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailTypeView: UILabel!
    @IBOutlet weak var detailCommentView: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailMapView: MKMapView!
    var chosenPlaceId = ""
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //viewcontrolleri direkt light a çeviren kü.ük kodd
        overrideUserInterfaceStyle = .light
        
        getDataFromParse()
        detailMapView.delegate = self
        
      
        }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            }else {
                if objects != nil {
                   
                        let chosenPlaceObject = objects![0]
                        
                    if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                        self.detailNameLabel.text = placeName
                    }
                    if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                        self.detailTypeView.text = placeType
                    }
                    if let placeComment = chosenPlaceObject.object(forKey: "comment") as? String {
                        self.detailCommentView.text = placeComment
                    }
                    if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                        if let placeLatitudeDouble = Double(placeLatitude) {
                            self.chosenLatitude = placeLatitudeDouble
                        }
                    }
                    if let placeLongitude = chosenPlaceObject.object(forKey: "longitute") as? String{
                        if let placeLongitudeDouble = Double(placeLongitude) {
                            self.chosenLongitude = placeLongitudeDouble
                        }
                    }

                    if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { data, error in
                            if error == nil {
                                if data != nil {
                                    self.detailImageView.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                    
                    // MAP KISMI
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
                    
                    let region = MKCoordinateRegion(center: location, span: span)
                    
                    self.detailMapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detailNameLabel.text!
                    annotation.subtitle = self.detailCommentView.text!
                    self.detailMapView.addAnnotation(annotation)
                    
                    
                    }
                }
            }
        
    
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            return nil
        }
        
        let reusedId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusedId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reusedId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else{
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if self.chosenLatitude != 0.0 && self.chosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                         
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailNameLabel.text
                        
                        let lounchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: lounchOptions)
                    }
                }
            }
            
        }
        
    }
    
    }
    


