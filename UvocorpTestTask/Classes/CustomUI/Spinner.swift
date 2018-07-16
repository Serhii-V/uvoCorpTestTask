//
//  ActivitySpinner.swift
//  UvocorpTestTask
//
//  Created by Serhii on 7/16/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit
import SnapKit



class Spinner: UIView {
    private var activityView: UIView?
    private var spinner: UIActivityIndicatorView?
    private var spinnerDidShow = NSNotification.Name("spinnerDidShow")

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }


    convenience init(start: Bool = false) {
        self.init()
        if start { self.start() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

        NotificationCenter.default.addObserver(forName: spinnerDidShow, object: self, queue: OperationQueue.main) { notification in
            if (notification.object as! UIView) != self {
                self.stop()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        let spinnerSize = 50
        let size = CGSize(width: spinnerSize, height: spinnerSize)
        let xPoint = UIScreen.main.bounds.width / 2 - CGFloat(spinnerSize / 2)
        let yPoint = UIScreen.main.bounds.height / 2 - CGFloat(spinnerSize / 2)
        let point = CGPoint(x: xPoint, y: yPoint)
        backgroundColor = .clear
        activityView = UIView(frame: CGRect(origin: point, size: size))
        self.frame = CGRect(origin: point, size: size)
        addSubview(activityView!)

        activityView?.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(size)
        }

        spinner = UIActivityIndicatorView()
        spinner?.color = .white
        spinner?.center = activityView!.center
        spinner?.hidesWhenStopped = true
        activityView?.addSubview(spinner!)

        spinner?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        activityView?.layer.cornerRadius = 10
        activityView?.layer.masksToBounds = true
    }

    func start() {
        if let vc = UIApplication.topViewController()?.tabBarController { spin(vc.selectedViewController!) }
        else if let vc = UIApplication.topViewController()?.navigationController { spin(vc) }
        else if let vc = UIApplication.topViewController() { spin(vc) }
        NotificationCenter.default.post(name: spinnerDidShow, object: self)
    }

    private func spin(_ vc: UIViewController) {
        vc.view.addSubview(self)
        spinner?.startAnimating()
    }

    func stop() {
        spinner?.stopAnimating()
        self.removeFromSuperview()
    }

}
