//
//  IdentifiedImageView.swift
//  ios-sources-assignment
//
//  Created by hyperactive on 27/05/2021.
//  Copyright © 2021 Chegg. All rights reserved.
//

import UIKit

class IdentifiedImageView: UIImageView {
    
    private var didSetFailureLabel = false
    var id: String? // needed for checking each image to its respectfull downloaded one 
    
    private var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    private var failureLabel : UILabel = {
        let label = UILabel()
        label.text = "Sorry, No Image"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.alpha = 0
        return label
    }()
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        if let image = image {
            removeFailureLabel()
            self.image = image
        } else {
            handleNoImage()
        }
    }
    
    public func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func handleNoImage() {
        if !self.didSetFailureLabel {
            self.didSetFailureLabel = true
            self.setupFailureLabel()
            self.showFailureLabel()
        } else {
            showFailureLabel()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .orange
        addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    private func setupFailureLabel() {
        addSubview(failureLabel)
        
        failureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        failureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func removeFailureLabel() {
        failureLabel.removeFromSuperview()
        didSetFailureLabel = false
    }
    
    private func showFailureLabel() {
        UIView.animate(withDuration: 0.4) {
            self.failureLabel.alpha = 1.0
        }
    }

}
