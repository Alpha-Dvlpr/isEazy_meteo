//
//  BaseView.swift
//  isEazy meteo
//
//  Created by Aarón Granado Amores on 6/3/23.
//

import Foundation
import UIKit

typealias RetryCallback = (() -> Void)

class BaseVC: UIViewController {

    private static let overlayID = 1_000_000
    
    func startLoading() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.view.isUserInteractionEnabled = false
            self.addOverlay()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.removeOverlay()
        }
    }
    
    func showAlert(for error: Error, retry: RetryCallback? = nil) {
        let alert = UIAlertController(title: Localize.Base.info, message: error.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Localize.Base.accept, style: .default) { _ in close() }
        let retryButton = UIAlertAction(title: Localize.Base.retry, style: .destructive) { _ in close(); retry?() }
        
        func close() { alert.dismiss(animated: true, completion: nil) }
        
        alert.addAction(okButton)
        if retry != nil { alert.addAction(retryButton) }
        
        DispatchQueue.main.async { self.present(alert, animated: true, completion: nil) }
    }
    
    private func addOverlay() {
        self.removeOverlay()
        
        self.view.layer.zPosition = 10
        
        let overlay: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray
            view.alpha = 0.8
            view.tag = BaseVC.overlayID
            view.layer.zPosition = 100
            
            return view
        }()
        
        let indicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView()
            view.style = UIActivityIndicatorView.Style.white
            view.color = .systemBlue
            view.layer.zPosition = 1_000
            
            return view
        }()
        
        [
            overlay,
            indicator
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        overlay.addSubview(indicator)
        self.view.addSubview(overlay)
        
        overlay.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        overlay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        overlay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        overlay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        indicator.centerXAnchor.constraint(equalTo: overlay.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: overlay.centerYAnchor).isActive = true
        indicator.startAnimating()
    }
    
    private func removeOverlay() {
        let overlay = self.view.viewWithTag(BaseVC.overlayID)
        overlay?.removeFromSuperview()
    }
}
