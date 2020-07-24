//
//  Constants.swift
//  Weather
//
//  Created by Nick Chekmazov on 23.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

import Alamofire

struct Constants {
    struct WeatherServer {
        static let baseURL = "http://api.weatherstack.com"
    }
    
    struct APIParameterKey {
        static let accessKey = "ca0d0df20016646536599d7c813e68a8"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}
