//
//  Date.swift
//  challengePhi
//
//  Created by Angela Alves on 24/08/22.
//

import Foundation
import UIKit

enum Style {
    case short
    case long
    case none

    var dateFormat: String {
        switch self {
            case .short:
                return "dd/MM"
            case .long:
                return "dd/MM/yyyy"
            case .none:
                return ""
        }
    }

    var timeFormat: String {
        switch self {
            case .short:
                return "HH:mm"
            case .long:
                return "HH:mm:ss"
            case .none:
                return ""
        }
    }
}

class PHDate {

    // MARK: Properties
    let rawValue: Date
    private let dateFormatter = DateFormatter()
    private let dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

    init(rawValue: Date) {
        self.rawValue = rawValue
    }

    // MARK: Init

    init?(dateString string: String?) {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = dateFormat

        if let date = formatter.date(from: string ?? "") {
            rawValue = date
        } else {
            return nil
        }
    }

    // MARK: Aux

    func string(dateStyle: Style = .none, timeStyle: Style = .none) -> String {
        let date = dateString(style: dateStyle)
        let time = timeString(style: timeStyle)

        switch (dateStyle, timeStyle) {
            case (.none, .none):
                return ""
            case (.short, .none):
                return date
            case (.long, .long):
                return [date, time].joined(separator: " - ")
            default:
                return date
        }
    }

    private func dateString(style: Style) -> String {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = style.dateFormat

        return dateFormatter.string(from: rawValue)
    }

   private func timeString(style: Style) -> String {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = style.timeFormat

        return dateFormatter.string(from: rawValue)
    }
}
