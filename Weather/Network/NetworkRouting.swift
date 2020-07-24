//
//  NetworkRouting.swift
//  Weather
//
//  Created by Nick Chekmazov on 23.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

import Alamofire

enum NetworkRouting: APIConfig {
    
    case fetchWeather(city: String)
 
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .fetchWeather:
            return .get
        }
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "/current"
        }
    }
    
    // MARK: - Parameters
    
    var parameters: RequestParams {
        switch self {
        case .fetchWeather(let city):
            return .url(["access_key": Constants.APIParameterKey.accessKey, "query": city])
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.WeatherServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        // Parameters
       
        switch parameters {
            
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
        case .url(let params):
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
        }
        
        return urlRequest
    }
}
