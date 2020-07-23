//
//  ViewController.swift
//  Weather
//
//  Created by Екатерина Вишневская - ВТБ on 20.07.2020.
//  Copyright © 2020 ВТБ Юниор iOS. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Constants
    var locationLabel = UILabel()
    var weatherLabel = UILabel()
    var cities = ["Russia\nMoscow", "Great Britain\nLondon"]
    var scrollView = UIScrollView()
    let pageControl = UIPageControl()
    var pagesViews: [UIView] = []
    let locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let location = getCurrentLocation()
        pageControl.numberOfPages = cities.count + 1
        var location: String?
        var bounds: CGRect = .zero
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let addButton = UIButton()
        addButton.setTitle("Add city", for: .normal)
        addButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addButton.layer.borderWidth = 2
        addButton.layer.cornerRadius = 15
        addButton.layer.masksToBounds = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100), scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor), scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width*(CGFloat( cities.count + 1)), height: scrollView.frame.size.height)
        
        for i in 0..<cities.count + 1 {
            location = i == 0 ? getCurrentLocation() : cities[i-1]
            let pageView = setPage(location: location, weather: "test")
            scrollView.addSubview(pageView)
            NSLayoutConstraint.activate([
                pageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                pageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                pageView.leadingAnchor.constraint(equalTo: i == 0 ? scrollView.leadingAnchor : pagesViews[i-1].trailingAnchor), pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
            pagesViews.append(pageView)
        }
        
    }
    
    //MARK: - UI
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
    
    private func setPage (location: String?, weather: String?) -> UIView {
        let pageView = UIView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        locationLabel = createLabel(text: location ?? "Unknown")
        weatherLabel = createLabel(text: weather ?? "Unknown")
        setPageLayout(pageView: pageView)
        pageView.backgroundColor = .blue
        return pageView
    }

    private func setPageLayout(pageView: UIView) {
        
        pageView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 110),
            locationLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 90),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        pageView.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: locationLabel.topAnchor, constant: 110),
            weatherLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            weatherLabel.heightAnchor.constraint(equalToConstant: 90),
            weatherLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
        
    }
    
    //MARK: - Function for showing current location: Country&city
    
    private func getCurrentLocation() -> String? {
        
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return nil
        }
        
        var output = "Our location is:"
        
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
           
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            
        }
        
        return output
    }

}

extension WeatherViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
                
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
                
                // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
                
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
                

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
    }
}

