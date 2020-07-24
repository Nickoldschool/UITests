//
//  Network.swift
//  Weather
//
//  Created by Nick Chekmazov on 21.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

import Alamofire

class Network: NSObject {
    
    //static var network = Network()
    
    var imageView = UIImageView()
    
    //MARK: - Get data
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //MARK: - Download image

    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    
}
