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
        
       
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
       
        if let jsonString = URL(string:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.5393771,-81.3816546&radius=500&type=night_club&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI"){
            
            let googleTask = session.dataTask(with: jsonString, completionHandler: { (data, response, error) in
                
                if let error = error{
                    print("it failed" + error.localizedDescription)
                }
                
                guard let httpsResponse = response as? HTTPURLResponse,
                httpsResponse.statusCode == 200,
                let validData = data
                    else{print("json failed"); return}
                
                do {
                    if let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String:Any]{
                        if let results = jsonObj["results"] as? [Any]{
                            print(results)
                        }
                        
                    }
                    // self.Parse(jsonObject: jsonObj as! [Any]) this is where I get my json data from google api.
                    
                   // let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers)
//                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
//
//                    self.Parse(jsonObject: jsonObj as! [Any])
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            })
            googleTask.resume()

        }
        


    } //end of VIEW DID LOAD
    
    func Parse(jsonObject: [Any]? ){
        
        guard let json = jsonObject
            else { print("Parse Failed to Unwrap jsonObject."); return }
        
        for res in json{
            guard let results = res as? [String:Any],
                let geo = results["geometry"] as? String
//                let loc = results["Locations"] as? [String:Any],
//                let lat = loc ["lat"] as? String,
//                let lng = loc ["lng"] as? String,
//                let name = results["name"] as? String,
//                let openHours = results["opening_hours"] as? [String:Any],
//                let openNow = openHours["open_now"] as? Bool,
//                let rate = results["rating"] as? Double,
//                let address = results["vicinity"] as? String
            
                else{
                    continue
            }
        }
    }
    
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
