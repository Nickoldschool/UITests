//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Вишневская - ВТБ on 20.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

//
//  ViewController.swift
//  Homework6
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
protocol ViewControllerInput {
    func dataLoaded()
}

class WeatherViewController: UIViewController {

    // MARK: - Properties

    private var collectionView: UICollectionView!
    private var cellModels: [CellModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        loadData()
        
    }
    
    
    // MARK: - Configurations
    
    private func setCollectionView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        let flowLayout = UICollectionViewFlowLayout ()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor), collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor), collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.cellID)
    }

    private func loadData() {
        
        cellModels.append(getCurrentLocation() ?? CellModel(location: "Our location is:\nUnknown", city: nil))
        cellModels.append(contentsOf: [CellModel(country: "Russia", city: "Moscow"), CellModel(country: "Greate Britain", city: "London"), CellModel(country: "Germany", city: "Berlin")])
        
    }
}



// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellID, for: indexPath) as? Cell {
            cell.viewModel = cellModels[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    //MARK: - Location
    
    private func getCurrentLocation() -> CellModel? {
        let locationManager = LocationManager()
        
        guard let exposedLocation = locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return nil
        }
        
        var location = "Our location is:"
        var city = ""
        locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            
            if let country = placemark.country {
                location = location + "\n\(country)"
            }
           
            if let town = placemark.locality {
                location = location + "\n\(town)"
                city = town
            }
            
        }
        
        return CellModel.init(location: location, city: city)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension WeatherViewController: ViewControllerInput {
    
    func dataLoaded() {
        // Do something
    }
}



