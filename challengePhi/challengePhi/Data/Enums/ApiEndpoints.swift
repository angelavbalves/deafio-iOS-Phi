//
//  ApiEndpoint.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation

enum ApiEndpoints {
    case balance
    case statement(limit: Int = 10, offset: Int)
    case detailStatement(id: String)
}

extension ApiEndpoints: Endpoint {
    var host: String {
        return "desafio-mobile-bff.herokuapp.com"
    }

    var method: String {
        return "get"
    }

    var path: String {
        switch self {
            case .balance:
                return "/myBalance"
            case .statement(let limit, let offset):
                return "/myStatement/\(limit)/\(offset)"
            case .detailStatement(let id):
                return "/myStatement/detail/\(id)/"
        }
    }


}
