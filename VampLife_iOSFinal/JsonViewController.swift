//
//  jsonViewController.swift
//  VampLife_iOSFinal
//
//  Created by Brittany Darby on 3/5/18.
//  Copyright © 2018 Brittany Darby. All rights reserved.
//

import UIKit

class JsonViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let jsonString = URL(string:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.5393771,-81.3816546&radius=500&type=night_club&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI")!
        
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
                            if let apiResultsOutPut = valueCast{
                                if let apiGeometry = apiResultsOutPut["geometry"] as? [String: Any]{
                                    //print(apiGeometry)
                                    if let apiLocation = apiGeometry["location"] {
                                        print(apiLocation)
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
