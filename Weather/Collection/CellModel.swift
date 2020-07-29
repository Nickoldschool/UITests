//
//  CellModel.swift
//  Homework6
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
import Alamofire

class CellModel: NSObject {
    
    var location: String?
    var weather: String?  {
        get {
            var temp = "-°"
            let network = Network()
            guard let city = city
                else {return temp}
            AF.request(NetworkRouting.fetchWeather(city: city))
                .validate(statusCode: 200..<300)
                .responseDecodable { (response: AFDataResponse<Weather>) in
                    switch response.result {
                    case .success(let response):
                        print("Success")
                        print(response)
                        temp = String(response.current.temperature) + "°"
                        print("Current temperature is \(temp)")
                        let url = URL(string: response.current.weatherIcons[0])!
                        network.downloadImage(from: url)
                    case .failure(let error):
                        print(error)
                    }
            }
            return temp
            
        }
    }
    
    var country: String?
    var city: String?
    
    init(location: String, city: String?) {
        self.location = location
        self.city = city
    }
    
    init(country:String, city: String) {
        
        self.location = country+"\n"+city
        self.country = country
        self.city = city
    }
    
    
}
