//
//  CurrentTimeCellViews.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation
import UIKit

struct CurrentTimeCellViews {
    
    // MARK: - UI Variables
    // ====================
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 24)
        
        return label
    }()
    
    private var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 18)
        
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 48 : 18)
        
        return label
    }()
    
    private var hourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 48 : 18)
        
        return label
    }()
    
    private var image = WebImageView.create()
    
    // MARK: - View Building
    // =====================
    init(inside view: UIView) {
        view.subviews.forEach {
            $0.removeFromSuperview()
            $0.subviews.forEach { $0.removeFromSuperview() }
        }
        
        self.addViews(inside: view)
        self.setConstraints(inside: view)
    }
    
    private func addViews(inside view: UIView) {
        [
            self.container,
            self.cityLabel,
            self.detailStack,
            self.image,
            self.descriptionLabel,
            self.temperatureLabel,
            self.hourLabel
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        view.addSubview(self.container)
        
        self.container.addSubview(self.image)
        self.container.addSubview(self.cityLabel)
        self.container.addSubview(self.descriptionLabel)
        self.container.addSubview(self.detailStack)
        
        self.image.layer.zPosition = 10
        self.cityLabel.layer.zPosition = 100
        self.descriptionLabel.layer.zPosition = 100
        self.container.layer.zPosition = 100
        
        self.detailStack.addArrangedSubview(self.hourLabel)
        self.detailStack.addArrangedSubview(UIView())
        self.detailStack.addArrangedSubview(self.temperatureLabel)
    }
    
    private func setConstraints(inside view: UIView) {
        self.container.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        self.container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        self.container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        self.cityLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 16).isActive = true
        self.cityLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16).isActive = true
        self.cityLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -16).isActive = true
       
        self.descriptionLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 8).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -16).isActive = true
        
        self.detailStack.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -8).isActive = true
        self.detailStack.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16).isActive = true
        self.detailStack.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -16).isActive = true
        
        self.image.topAnchor.constraint(equalTo: self.container.topAnchor).isActive = true
        self.image.bottomAnchor.constraint(equalTo: self.container.bottomAnchor).isActive = true
        self.image.leadingAnchor.constraint(equalTo: self.container.leadingAnchor).isActive = true
        self.image.trailingAnchor.constraint(equalTo: self.container.trailingAnchor).isActive = true
    }
    
    // MARK: - Data Setting
    // ====================
    func set(data: WeatherData) {
        guard let hourly = data.hourly.first,
              let weather = hourly.weather.first
        else { self.clear(); return }
        
        self.cityLabel.text = data.cityName
        self.container.backgroundColor = weather.color
        self.image.loadImage(from: weather.imageURL)
        self.hourLabel.text = Date(timeIntervalSince1970: Double(hourly.dTime)).toHourString()
        self.descriptionLabel.text = weather.description.capitalized
        self.temperatureLabel.text = hourly.temp.toTemp()
    }
    
    func clear() {
        self.cityLabel.text = .none
        self.container.backgroundColor = .clear
        self.image.clear()
        self.hourLabel.text = .none
        self.descriptionLabel.text = .none
        self.temperatureLabel.text = .none
    }
}
