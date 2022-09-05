//
//  PHView.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation
import UIKit

class PHView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureSubviews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {}
    func configureConstraints() {}
}
