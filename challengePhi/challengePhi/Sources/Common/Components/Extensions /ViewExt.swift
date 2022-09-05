//
//  ViewExt.swift
//  challengePhi
//
//  Created by Angela Alves on 01/09/22.
//

import Foundation
import UIKit

public extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
