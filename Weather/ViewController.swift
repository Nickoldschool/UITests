//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Вишневская - ВТБ on 20.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class ViewController: UIViewController {
    
    //MARK: - Constants
    let locationLabel = UILabel()
    let locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0.4950722456, blue: 0.819293201, alpha: 1)
        
        createLabel()
        setCurrentLocation()
        
    }
    
    //MARK: - Create label for location detection
    
    private func createLabel() {
        
        locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationLabel.textAlignment = .center
        locationLabel.layer.borderWidth = 2
        locationLabel.layer.cornerRadius = 15
        locationLabel.layer.masksToBounds = true
        locationLabel.numberOfLines = 0
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 90),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
    }

    //MARK: - Function for showing current location: Country&city
    
    private func setCurrentLocation() {
        
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            var output = "Our location is:"
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
           
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            self.locationLabel.text = output
        }
    }

}

