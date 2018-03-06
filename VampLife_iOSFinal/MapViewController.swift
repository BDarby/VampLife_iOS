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

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let jsonString = URL(string:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.5393771,-81.3816546&radius=500&type=night_club&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI")!
        
        
        let jsonPhoto = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAASSPcQ-PRcadh8JxvrTixhGr7Ktlk0tH2suzvbrT2iwHQOZHYPVtDWKzh-cbeVzfoqzUH7kD--AJ2a5cyF3JyBhevxyiu-kO3wJ6wpeCJLzk7NzSAZmqG88oROFzh3VKSEhBTvkvYyFCJqEgvpfd4BI3IGhQ2kIlbnwN7xeA4ZiRXxeu_o2C7Rw&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI"
        
        
        let config = URLSession.shared
        
        let request = URLRequest(url: jsonString)
        
        
        //print("test==================")
        
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
                                
                                if let apiOpenHours = apiResultsOutPut["opening_hours"] as? [String:Any]{
                                    if let apiOpenNow = apiOpenHours["open_now"] as? Bool {
                                        print(apiOpenNow)
                                    }
                                }
                                if let apiPhoto =  apiResultsOutPut["photos"] as? [[String:Any]]{
                                    for photo in apiPhoto {
                                        if let apiPhotoRef = photo["photo_reference"] as? String{
                                            print(apiPhotoRef)
                                        }
                                    }
                                }
                                
                                if let apiRating = apiResultsOutPut["rating"] as? Double{
                                    print(apiRating)
                                }
                                
                                if let apiVicinity = apiResultsOutPut["vicinity"] as? String{
                                    print(apiVicinity)
                                }
                                
                                
                                if let apiName = apiResultsOutPut["name"] as? String {
                                    print(apiName)
                                }
                                if let apiGeometry = apiResultsOutPut["geometry"] as? [String: Any]{
                                    //print(apiGeometry)
                                    if let apiLocation = apiGeometry["location"] as? [String:Double]{
                                        if let apiLat = apiLocation["lat"] {
                                            print(apiLat)
                                        }
                                        if let apiLng = apiLocation["lng"] {
                                            print(apiLng)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        print(resultsArray)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
        googleTask.resume()

    } //end of VIEW DID LOAD
    
   
    
//    func displayToMap(){
//        DispatchQueue.main.async {
//            //this is where I would display markers to the map...somehow.
//
//        }
//
//    }
//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
