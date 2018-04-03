//
//  ManagerCity.swift
//  DemoWeather
//
//  Created by Bharat Byan on 02/04/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation
import CoreData

// MARK:- Protocols

protocol ProtocolManagerCityList{
    func sendData(viewModel: ViewModelCity, success: Bool)
}

class ManagerCity{
    static let sharedInstance = ManagerCity()
    var delegate: ProtocolManagerCityList?
    
    //Instead of single viewModel send array of viewModel
    var archivedModel:ModelCity = ModelCity()
    
    var client: NetWork?
    
    // MARK:- Creating Model
    
    func createPerson(_ searchedCity: String, userKey: String){
        
        client = NetWork(apiKey: userKey, temperatureFormat: NetWork.TemperatureFormat.Celsius)
        
        client?.currentWeather(searchedCity) { result in
            switch result {
            case .Error(_, let error):
                print("Error: \(String(describing: error!))")
            case .success(_, let dictionary):
                do {
                print( "Received data: \(String(describing: dictionary!))")
                
                    //FIXME: do something else here foor error code handling
                    var code = -1
                    if let dict = dictionary {
                        
                        if let apiCode = dict["cod"] as? Int {
                            code = apiCode
                        }
                        else if let apiCode = dict["cod"] as? String, let intValue = Int(apiCode) {
                            code = intValue
                        }
                    }
                                       
                    if code == 404{
                        //FIXME: dont send empty viewmodel, also use dynamic error message to the user display
                        let viewModel = ViewModelCity.init(self.archivedModel)
                        self.delegate?.sendData(viewModel: viewModel, success: false)
                        print("city not found")
                    }else if code == 200 {
                        let city = dictionary?["name"] as? String
                        let dict = dictionary?["main"] as? NSDictionary
                        let temperature = dict?["temp"] as! NSNumber
                        let dict2 = dictionary?["sys"] as? NSDictionary
                        let country = dict2!["country"] as? String
                        
                        self.archivedModel.cityName = city
                        self.archivedModel.countryCode = country
                        self.archivedModel.temp = temperature.stringValue
                        
                        //Instead of single viewModel send array of viewModel
                        self.getCity(self.archivedModel)
                    }
                }
            }
        }
    }
    
    // MARK:- Delegation Sending
    
    func getCity(_ model: ModelCity){
    
        let viewModel = ViewModelCity.init(model)
        delegate?.sendData(viewModel: viewModel, success: true)
    }
}
