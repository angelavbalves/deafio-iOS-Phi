//
//  PHLoadingView.swift
//  challengePhi
//
//  Created by Angela Alves on 26/08/22.
//

import Foundation
import UIKit
import TinyConstraints

class PHLoadingView: PHView {

    // MARK: Init
    override init() {
        super.init()
        self.backgroundColor = .white
        isHidden = true
    }

    // MARK: Views
    let activeIndicator = UIActivityIndicatorView(style: .large)

    override func configureSubviews() {
        addSubview(activeIndicator)
    }

    override func configureConstraints() {
        activeIndicator.centerInSuperview()
    }

    func show() {
        isHidden = false
        activeIndicator.startAnimating()
    }

    func hide() {
        isHidden = true
        activeIndicator.stopAnimating()
    }
}
