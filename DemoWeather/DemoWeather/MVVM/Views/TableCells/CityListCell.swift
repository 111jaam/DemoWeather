//
//  CityListCell.swift
//  DemoWeather
//
//  Created by Bharat Byan on 02/04/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
