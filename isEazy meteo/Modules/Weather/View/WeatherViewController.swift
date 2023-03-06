//
//  WeatherViewController.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 5/3/23.
//

import CoreLocation
import UIKit

class WeatherViewController: BaseVC {

    // MARK: - Class variables
    // =====================
    private var viewModel: WeatherVM?
    private var views: WeatherVCViews?
    
    // MARK: - UI Life Cycle
    // ====================
    static func newInstance() -> WeatherViewController {
        let controller = WeatherViewController()
        controller.viewModel = WeatherVM(service: NetServices())
        controller.viewModel?.netServices?.manager = ServiceManager()
        controller.views = WeatherVCViews()
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.setDelegate(self)
        
        _ = self.viewModel?.authorizationStatus.observeNext {
            self.views?.create(inside: self.view, for: $0)
            self.views?.set(self, self)
            self.setupActions()
            
            if $0 == .authorizedAlways || $0 == .authorizedWhenInUse {
                self.viewModel?.getData()
                self.view.backgroundColor = UIColor.defaultBlue
            } else {
                self.view.backgroundColor = .white
            }
        }
        
        _ = self.viewModel?.state.observeNext {
            switch $0 {
            case .idle: self.stopLoading()
            case .loading: self.startLoading()
            case .error(let error): self.showAlert(for: error) { self.viewModel?.getData() }
            }
        }
        
        _ = self.viewModel?.data.observeNext { _ in
            self.views?.reload()
            self.views?.hideTableLoader()
        }
    }
    
    // MARK: - UI Actions
    // ==================
    private func setupActions() {
        self.views?.getButton().addTarget(self, action: #selector(self.permissionButtonAction(_:)), for: .touchUpInside)
        self.views?.getLoader().addTarget(self, action: #selector(self.reloadWeather(_:)), for: .valueChanged)
    }
    
    @objc private func permissionButtonAction(_ sender: UIButton) {
        self.viewModel?.requestPermission()
    }
    
    @objc private func reloadWeather(_ sender: UIRefreshControl) {
        self.viewModel?.getData()
    }
}

// MARK: - Location Delegate
// =========================
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manger: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if self.viewModel?.authorizationStatus.value != status {
            self.viewModel?.authorizationStatus.value = status
        }
    }
}

// MARK: - UITableView Delegate & DataSource
// =========================================
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (self.viewModel?.data.value?.hourly.count ?? 1) - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0
            ? (self.view.safeAreaLayoutGuide.layoutFrame.size.height / 2)
            : (UIDevice.current.userInterfaceIdiom == .pad ? 96 : 150)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let data = self.viewModel?.data.value {
                return CurrentTimeCell.create(with: data)
            }
        } else {
            if let data = self.viewModel?.data.value?.hourly[indexPath.row + 1] {
                return NextTimeCell.create(with: data)
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
