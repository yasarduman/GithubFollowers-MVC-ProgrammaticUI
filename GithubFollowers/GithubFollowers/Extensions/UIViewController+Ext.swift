//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit
import SafariServices

extension UIViewController {
    // MARK: - Custom Alerts
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
    }
    
// Presents a default error alert with a standard message.
    func presentDefualtError() {
        let alertVC = GFAlertVC(title: "Something Wnt Wrong !",
                                message: "We were unable to complete your task at this time . Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        self.present(alertVC, animated: true)
        
    }
    
    // MARK: - Safari View Controller
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    

}
