//
//  ErrorState.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation

enum ErrorState: Swift.Error {
    case generic
    case notFound
    case noConnection
    case badRequest
}
