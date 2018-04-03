//
//  ViewModelCity.swift
//  DemoWeather
//
//  Created by Bharat Byan on 02/04/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation

class ViewModelCity {
    
    var cityDetails: String?
    var temperature: String?
    
    init(_ model: ModelCity){
        cityDetails = model.cityName! + ", " + model.countryCode! 
        temperature = model.temp! + "°C"
    }
}
