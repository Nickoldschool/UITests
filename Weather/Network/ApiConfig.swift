//
//  ApiConfig.swift
//  Weather
//
//  Created by Nick Chekmazov on 23.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

import Alamofire

protocol APIConfig: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}
