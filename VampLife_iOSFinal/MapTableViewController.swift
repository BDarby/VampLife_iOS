//
//  MapTableViewController.swift
//  VampLife_iOSFinal
//
//  Created by Brittany Darby on 3/24/18.
//  Copyright © 2018 Brittany Darby. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Mapbox

class MapTableViewController: UITableViewController {
    
    
    @IBOutlet var mNameLabel: UILabel!
    
    @IBOutlet var mTimeLabel: UILabel!
    
    @IBOutlet var mRatingLabel: UILabel!
    
    @IBOutlet var mAddressLabel: UILabel!
    
    
       var clubObjArray:[ClubObjects] = []
    
    
      let jsonString = URL(string:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.5393771,-81.3816546&radius=500&type=night_club&key=AIzaSyAUukffqwB5tf4oS1puWq8HE1nOk4t_sGI")!
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
                        
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
        googleTask.resume()
        
        
        
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
   
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 1
        return clubObjArray.count
        
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MapTableViewCell else {
            
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
        }
        
       
      let currentClub = clubObjArray[indexPath.row]
            
            cell.mName.text = currentClub.name
            cell.mRatings.text = String(currentClub.ratings)
            cell.mAddress.text = currentClub.address
            cell.mHours.text = String(currentClub.time)
            
        
       
        
        

        // Configure the cell...

        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
