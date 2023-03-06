//
//  NextTimeCell.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import UIKit

class NextTimeCell: UITableViewCell {

    private var views: NextTimeCellViews?
    
    // MARK: - Configuration
    // =====================
    static func create(with data: WeatherModel) -> NextTimeCell {
        let view = NextTimeCell()
        view.backgroundColor = .white
        view.views = NextTimeCellViews(inside: view)
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
