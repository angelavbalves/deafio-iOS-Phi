//
//  Endpoint.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation

protocol Endpoint {
    var host: String { get }
    var method: String { get }
    var path: String { get }
    
}
