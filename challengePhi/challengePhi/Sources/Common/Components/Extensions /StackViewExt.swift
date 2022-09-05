//
//  StackViewExt.swift
//  challengePhi
//
//  Created by Angela Alves on 01/09/22.
//

import Foundation
import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
