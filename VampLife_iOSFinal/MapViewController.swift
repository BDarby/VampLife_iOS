//
//  MapViewController.swift
//  VampLife_iOSFinal
//
//  Created by Brittany Darby on 2/21/18.
//  Copyright © 2018 Brittany Darby. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GooglePlaces
import GoogleMaps
import Mapbox

class MapViewController: UIViewController,  MGLMapViewDelegate {
    
    
    @IBOutlet var MapCard: UIView!
    
    @IBOutlet var mapView: MGLMapView!
    
    
  
    
    var clubObjArray:[ClubObjects] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.setCenter(CLLocationCoordinate2D(latitude:28.5393771, longitude: -81.3816546 ), zoomLevel:9, animated: true)
        
       
        let jsonString = URL(string:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.5393771,-81.3816546&radius=500&type=night_club&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI")!
        
        
        let jsonPhoto = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAASSPcQ-PRcadh8JxvrTixhGr7Ktlk0tH2suzvbrT2iwHQOZHYPVtDWKzh-cbeVzfoqzUH7kD--AJ2a5cyF3JyBhevxyiu-kO3wJ6wpeCJLzk7NzSAZmqG88oROFzh3VKSEhBTvkvYyFCJqEgvpfd4BI3IGhQ2kIlbnwN7xeA4ZiRXxeu_o2C7Rw&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI"
        
        
        let config = URLSession.shared
        
        let request = URLRequest(url: jsonString)
   
        
        let googleTask = config.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else{
                return
            }
            
            guard let data = data else{
                return
            }
            do{
                
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                    
                    if let resultsArray = jsonObj["results"] as? [Any] {
                        
                        for apiResults in resultsArray{
                            let valueCast = apiResults as? [String:Any]
                            if let apiResultsOutPut = valueCast {
                                let clubsObj = ClubObjects()
                                if let apiOpenHours = apiResultsOutPut["opening_hours"] as? [String:Any]{
                                    if let apiOpenNow = apiOpenHours["open_now"] as? Bool {
                                        clubsObj.time = apiOpenNow
                                        
                                    }
                                }
                                if let apiPhoto =  apiResultsOutPut["photos"] as? [[String:Any]]{
                                    for photo in apiPhoto {
                                        if let apiPhotoRef = photo["photo_reference"] as? String{
                                            clubsObj.photoReference = apiPhotoRef
                                        }
                                    }
                                }
                                
                                if let apiRating = apiResultsOutPut["rating"] as? Double{
                                    clubsObj.ratings = apiRating
                                }
                                
                                if let apiVicinity = apiResultsOutPut["vicinity"] as? String{
                                    clubsObj.address = apiVicinity
                                }
                                
                                
                                if let apiName = apiResultsOutPut["name"] as? String {
                                    clubsObj.name = apiName
                                }
                                if let apiGeometry = apiResultsOutPut["geometry"] as? [String: Any]{
                                    //print(apiGeometry)
                                    if let apiLocation = apiGeometry["location"] as? [String:Double]{
                                        if let apiLat = apiLocation["lat"] {
                                            clubsObj.lat = apiLat
                                        }
                                        if let apiLng = apiLocation["lng"] {
                                            clubsObj.long = apiLng
                                        }
                                    }
                                    
                                }
                                self.clubObjArray.append(clubsObj)
                                print(self.clubObjArray)
                            }
                            
                        }
                        self.displayToMap()
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
        googleTask.resume()
       // mapView.addSubview(MapCard)
        
    } //end of VIEW DID LOAD
    
   
    
    func displayToMap(){
        DispatchQueue.main.async {
            //this is where I would display markers to the map...somehow.!
            let xibViews = Bundle.main.loadNibNamed("MapCard", owner: self, options: nil)
    
            
            var mapCard = xibViews![0] as? MapCard
                mapCard?.frame
           
//            NSLayoutConstraint.activate([
//                mapCard.heightAnchor.constraint(equalTo: correctLayoutGuide.heightAnchor, multiplier: 0.5)
//                mapCard.bottomAnchor.constraint(equalTo: correctLayoutGuide.bottomAnchor, constant: -20),
//                mapCard.trailingAnchor.constraint(equalTo: correctLayoutGuide.trailingAnchor, constant: 20)
//                ])
            
            for clubObject in self.clubObjArray{
                let annotation = MGLPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: clubObject.lat, longitude: clubObject.long)
                    annotation.title = clubObject.name
                    annotation.subtitle = clubObject.address
        
                    mapCard?.clubName.text = clubObject.name
                    mapCard?.clubImage.image = UIImage(named: clubObject.photoReference)
                    mapCard?.addressLabel.text = clubObject.address
                    mapCard?.hoursLabel.text = String(clubObject.time)
                    mapCard?.ratingLabel.text = String(clubObject.ratings)

                self.mapView.addAnnotation(annotation)

                //self.MapCard.addSubview(self.MapCard)
                self.view.addSubview(mapCard!)
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
  
        

        
        return nil
    }
    
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        
       
        return true
    }
    

}



