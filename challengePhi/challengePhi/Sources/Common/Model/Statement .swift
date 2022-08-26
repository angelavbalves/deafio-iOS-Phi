//
//  Statement .swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation

struct StatementResponse: Decodable {
    let items: [StatementItem]
}

struct StatementItem: Decodable {
    let createdAt: String
    let id: String
    let amount: Int
    let destiny: String?
    let description: String
    let tType: String
    let origin: String?
    let bankName: String?

    enum CodingKeys: String, CodingKey {
        case createdAt, id, amount, description, tType, bankName
        case destiny = "to"
        case origin = "from"
    }
}
