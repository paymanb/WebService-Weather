//
//  ViewController.swift
//  WebService
//
//  Created by Payman Bayat on 2/18/1396 AP.
//  Copyright © 1396 AP Payman Bayat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forecastLabel: UILabel!
    
    let Base_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Tehran&mode=json&units=metric&cnt=1&appid=dd0b7542f8b1bec8364d1480ab3f26f4"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastLabel.text = ""
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPSessionManager()
        
        manager.get(Base_URL, parameters: nil, progress: nil, success: { (operation, responseObject) in
            if let responseObject = responseObject {
                
                let json = JSON(responseObject)
                let forecast = json["list"][0]["weather"][0]["description"].string
                self.forecastLabel.text = forecast
                
                activityIndicatorView.removeFromSuperview()
                
                let temp = json["list"][0]["temp"]["day"].int
                
                if (temp! > 25) {
                    self.view.backgroundColor = UIColor.red
                } else if (temp! < 25) {
                    self.view.backgroundColor = UIColor.blue
                }
                
//                let weatherDict = responseObject as? Dictionary<String,AnyObject>
//                let days = weatherDict?["list"] as? [Dictionary<String,AnyObject>]
//                let tomorrow = days?[0]["weather"] as? [Dictionary<String,AnyObject>]
//                let tomorrowWeather = tomorrow?[0]["description"] as? String
//                self.forecastLabel.text = tomorrowWeather!
            }
        }) { (operation, error) in
            print("Error: " + error.localizedDescription)
        }
    }

}

