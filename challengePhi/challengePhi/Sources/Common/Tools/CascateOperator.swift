//
//  CascateOperator.swift
//  challengePhi
//
//  Created by Angela Alves on 23/08/22.
//

import Foundation

prefix operator ..
infix operator ..: MultiplicationPrecedence

/// Custom operator that lets you configure an instance inline
/// ```swift
/// self.frame = otherView.frame .. { $0.width = 1337 }
/// self.backgroundView = UIView() .. { $0.backgroundColor = .red }
/// ```
@discardableResult
func .. <T>(object: T, configuration: (inout T) -> Void) -> T {
    var object = object
    configuration(&object)
    return object
}
