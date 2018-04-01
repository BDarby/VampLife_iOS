//
//  MapTableViewCell.swift
//  VampLife_iOSFinal
//
//  Created by Brittany Darby on 3/24/18.
//  Copyright © 2018 Brittany Darby. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet var mName: UILabel!
    
    @IBOutlet var mRatings: UILabel!
    
    @IBOutlet var mAddress: UILabel!
    
    @IBOutlet var mHours: UILabel!
    
    
    
    @IBAction func favButton(_ sender: Any) {
        
        
       // var indexPath : IndexPath = Favorites
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
