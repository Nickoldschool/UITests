//
//  Cell.swift
//  Homework6
//
//  Created by Екатерина Вишневская - ВТБ on 05.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

final class Cell: UICollectionViewCell{

    // MARK: - Properties
    
    static let cellID = "cell"
    private let network = Network()
    
    var locationLabel = UILabel()
    var weatherLabel = UILabel()
    var weatherIcoImageView = UIImageView()
    
    var viewModel: CellModel? {
        didSet {
            if let viewModel = viewModel {
                updateContent(with: viewModel)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let pageView = setPage(location: viewModel?.location, weather: viewModel?.weather)
        contentView.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            pageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func getWeatherIconView() -> UIImageView{
        let image = network.imageView
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        return image
    }
    
    private func setPage (location: String?, weather: String?) -> UIView {
        let pageView = UIView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        locationLabel = createLabel(text: location ?? "Unknown")
        weatherLabel = createLabel(text: weather ?? "Unknown")
        weatherIcoImageView = getWeatherIconView()
        setPageLayout(pageView: pageView)
        pageView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
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
        
        
        pageView.addSubview(weatherIcoImageView)
        NSLayoutConstraint.activate([
            weatherIcoImageView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 30),
            weatherIcoImageView.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            weatherIcoImageView.heightAnchor.constraint(equalToConstant: 100),
            weatherIcoImageView.widthAnchor.constraint(equalToConstant: 120),
        ])
        
    }
    
    // MARK: - Public
    
    private func updateContent(with viewModel: CellModel) {
        locationLabel.text = viewModel.location
        weatherLabel.text = viewModel.weather
    }
}
