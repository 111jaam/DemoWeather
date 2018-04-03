//
//  ViewController.swift
//  DemoWeather
//
//  Created by Bharat Byan on 02/04/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
  
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView?
    @IBOutlet var textField: UITextField?
    @IBOutlet weak var tblList: UITableView!
    
    //Instead of single viewModel use array of viewModel
    var archivedModel:ViewModelCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pre-Fill textfield for Demo purpose only.
        textField?.text = "Chandigarh"
    }
    
    func getData(){
        activityIndicatorView?.startAnimating()
        
        ManagerCity.sharedInstance.delegate = self
        ManagerCity.sharedInstance.createPerson((textField?.text)!, userKey: "7b484b2c82b7086209d8c12b6d91d476")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            textField.resignFirstResponder()
            getData()
            
            return true
        }
        return false
    }
}

extension ViewController: ProtocolManagerCityList{
    func sendData(viewModel: ViewModelCity, success: Bool) {
        
        activityIndicatorView?.stopAnimating()
        
        guard success else {
            self.popupAlert(title: "Message", message: "City not found", actionTitles: ["Ok"], actions:[{action1 in
                }, nil])
            return
        }

        
        self.archivedModel = viewModel
        self.tblList.reloadData()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Instead of static return "1" viewModel's array count of viewModel.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCityList", for: indexPath) as! CityListCell
        
        cell.selectionStyle = .none
        
        //Instead of single viewModel use array of viewModel with [indexPath.row]
        let info = self.archivedModel
        cell.lblCityName.text = info?.cityDetails ?? "Chandigarh, IN"
        cell.lblCurrentTemp.text = info?.temperature ?? "30 °C"
        
        return cell
    }
}

extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

