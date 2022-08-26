//
//  PHTableView.swift
//  challengePhi
//
//  Created by Angela Alves on 23/08/22.
//

import TinyConstraints
import Foundation
import UIKit

class PHTableView: UITableView {

    public var headerView: UIView? {
        didSet {
            guard let headerView = headerView else {
                tableHeaderView = nil
                return
            }

            let containerView = UIView()

            containerView.addSubview(headerView)
            headerView.edgesToSuperview()

            tableHeaderView = containerView

            containerView.centerX(to: self)
            containerView.width(to: self)
            containerView.top(to: self)
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
