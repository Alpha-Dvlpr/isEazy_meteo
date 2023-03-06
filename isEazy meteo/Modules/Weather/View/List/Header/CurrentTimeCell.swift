//
//  CurrentTimeCell.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import UIKit

class CurrentTimeCell: UITableViewCell {

    private var views: CurrentTimeCellViews?
    
    // MARK: - Configuration
    // =====================
    static func create(with data: WeatherData) -> CurrentTimeCell {
        let view = CurrentTimeCell()
        view.backgroundColor = .white
        view.views = CurrentTimeCellViews(inside: view)
        view.views?.set(data: data)
        
        return view
    }
    
    // MARK: - Cell reloading
    // ======================
    override func prepareForReuse() {
        super.prepareForReuse()
        self.views?.clear()
    }
}
