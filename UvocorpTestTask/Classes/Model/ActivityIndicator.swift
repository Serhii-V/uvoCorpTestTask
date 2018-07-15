//
//  ActivityIndicator.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/14/18.
//  Copyright © 2018 Serhii. All rights reserved.
//
import UIKit


class LoaderController: NSObject {

    static let sharedInstance = LoaderController()
    private let activityIndicator = UIActivityIndicatorView()

    private func setupLoader() {
        removeLoader()

        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .white
    }

    func showLoader() {
        setupLoader()

        let appDel = UIApplication.shared.delegate as! AppDelegate
        let holdingView = appDel.window!.rootViewController!.view!

        DispatchQueue.main.async {
            self.activityIndicator.center = holdingView.center
            self.activityIndicator.startAnimating()
            holdingView.addSubview(self.activityIndicator)
           // UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }

    func removeLoader(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            //UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
