//
//  WeatherVCViews.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import CoreLocation
import Foundation
import UIKit

struct WeatherVCViews {
    
    // MARK: - UI Variables
    // ====================
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.backgroundColor = UIColor.defaultBackground.cgColor
        
        return view
    }()
    
    private var permissionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = Localize.Permissions.disclaimer
        
        return label
    }()
    
    private var permissionButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor.defaultGreen.cgColor
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitle(Localize.Permissions.button, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    
    private var weatherTable: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 12
        
        return table
    }()
    
    // MARK: - UI View Retrieving
    // ==========================
    func getButton() -> UIButton { return self.permissionButton }
    func getLoader() -> UIRefreshControl { return self.refreshControl }
    
    // MARK: - View Building
    // =====================
    func create(inside view: UIView, for status: CLAuthorizationStatus) {
        self.addViews(inside: view, for: status)
        self.setupConstraints(inside: view, for: status)
    }
    
    private func addViews(inside view: UIView, for status: CLAuthorizationStatus) {
        view.subviews.forEach {
            $0.removeFromSuperview()
            $0.subviews.forEach { $0.removeFromSuperview() }
        }
        
        switch status {
        case .notDetermined, .denied, .restricted: self.permissionBuild(inside: view)
        default: self.weatherBuild(inside: view)
        }
    }
    
    private func setupConstraints(inside view: UIView, for status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .denied, .restricted: self.permissionConstraints(inside: view)
        default: self.weatherConstraints(inside: view)
        }
    }
    
    // MARK: - Table Config
    // ====================
    func set(_ delegate: UITableViewDelegate, _ dataSource: UITableViewDataSource) {
        self.weatherTable.delegate = delegate
        self.weatherTable.dataSource = dataSource
    }
    
    func reload() { DispatchQueue.main.async { self.weatherTable.reloadData() } }
    
    func hideTableLoader() { DispatchQueue.main.async { self.refreshControl.endRefreshing() } }
}

// MARK: - Permission View Building
// ================================
extension WeatherVCViews {
    
    private func permissionBuild(inside view: UIView) {
        [
            self.container,
            self.permissionLabel,
            self.permissionButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        view.addSubview(self.container)
        
        self.container.addSubview(self.permissionLabel)
        self.container.addSubview(self.permissionButton)
    }
    
    private func permissionConstraints(inside view: UIView) {
        let safeArea = view.safeAreaLayoutGuide
        
        self.container.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        self.container.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16).isActive = true
        self.container.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        self.container.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
        
        self.permissionLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 36).isActive = true
        self.permissionLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 24).isActive = true
        self.permissionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -24).isActive = true
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            self.permissionButton.widthAnchor.constraint(equalToConstant: 400).isActive = true
            self.permissionButton.centerXAnchor.constraint(equalTo: self.container.centerXAnchor).isActive = true
        case .phone:
            self.permissionButton.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16).isActive = true
            self.permissionButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -16).isActive = true
        default: break
        }
        
        self.permissionButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -36).isActive = true
    }
}

// MARK: Weather List View Building
// ================================
extension WeatherVCViews {
    
    private func weatherBuild(inside view: UIView) {
        [
            self.weatherTable
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        view.addSubview(self.weatherTable)
        
        self.weatherTable.addSubview(self.refreshControl)
    }
    
    private func weatherConstraints(inside view: UIView) {
        let safeArea = view.safeAreaLayoutGuide
        
        self.weatherTable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        self.weatherTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16).isActive = true
        self.weatherTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        self.weatherTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
    }
}
