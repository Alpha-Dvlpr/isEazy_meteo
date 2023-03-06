//
//  NextTimeCellViews.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation
import UIKit

struct NextTimeCellViews {
    
    // MARK: - UI Variables
    // ====================
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        
        return view
    }()
        
    private var detailStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = UIDevice.current.userInterfaceIdiom == .pad ? 24 : 8
        
        return stack
    }()
    
    private var detailStack2: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = UIDevice.current.userInterfaceIdiom == .pad ? 24 : 8
        
        return stack
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 18 : 12)
        
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 18 : 12)
        
        return label
    }()
    
    private var hourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 18 : 12)
        
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
            self.detailStack,
            self.detailStack2,
            self.image,
            self.descriptionLabel,
            self.temperatureLabel,
            self.hourLabel
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        view.addSubview(self.container)
        
        self.container.addSubview(self.detailStack)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad: self.addPadViews()
        case .phone: self.addPhoneViews()
        default: break
        }
    }
    
    private func setConstraints(inside view: UIView) {
        self.container.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        self.container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        self.container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        self.container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad: self.setPadConstraints()
        case .phone: self.setPhoneConstraints(inside: view)
        default: break
        }
    }
    
    // MARK: - Data Setting
    // ====================
    func set(data: WeatherModel) {
        guard let weather = data.weather.first else { self.clear(); return }
        
        self.container.backgroundColor = weather.color
        self.image.loadImage(from: weather.imageURL)
        self.hourLabel.text = Date(timeIntervalSince1970: Double(data.dTime)).toHourString()
        self.descriptionLabel.text = weather.description.capitalized
        self.temperatureLabel.text = data.temp.toTemp()
    }
    
    func clear() {
        self.container.backgroundColor = .clear
        self.image.clear()
        self.hourLabel.text = .none
        self.descriptionLabel.text = .none
        self.temperatureLabel.text = .none
    }
}

// MARK: - Phone View Building
// ===========================
extension NextTimeCellViews {
    
    private func addPhoneViews() {
        self.detailStack.addArrangedSubview(self.image)
        self.detailStack.addArrangedSubview(self.detailStack2)

        self.detailStack2.addArrangedSubview(UIView())
        self.detailStack2.addArrangedSubview(self.hourLabel)
        self.detailStack2.addArrangedSubview(self.temperatureLabel)
        self.detailStack2.addArrangedSubview(self.descriptionLabel)
    }
    
    private func setPhoneConstraints(inside view: UIView) {
        self.detailStack.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 8).isActive = true
        self.detailStack.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16).isActive = true
        self.detailStack.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -16).isActive = true
        
        let freeWidth: CGFloat = (view.safeAreaLayoutGuide.layoutFrame.size.width / 2) - (16 * 4)
        
        self.image.widthAnchor.constraint(equalToConstant: freeWidth).isActive = true
    }
}

// MARK: - Pad View Building
// =========================

extension NextTimeCellViews {
    
    private func addPadViews() {
        self.detailStack.addArrangedSubview(self.hourLabel)
        self.detailStack.addArrangedSubview(self.image)
        self.detailStack.addArrangedSubview(self.temperatureLabel)
        self.detailStack.addArrangedSubview(self.descriptionLabel)
        self.detailStack.addArrangedSubview(UIView())
    }
    
    private func setPadConstraints() {
        self.detailStack.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 8).isActive = true
        self.detailStack.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -8).isActive = true
        self.detailStack.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16).isActive = true
        self.detailStack.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -16).isActive = true
    }
}
