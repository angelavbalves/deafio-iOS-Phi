//
//  StatementCell.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation
import TinyConstraints
import UIKit

class StatementCell: UITableViewCell {

    // MARK: Properties
    static let identifer = "idStatementList"

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private let totalStackView = UIStackView() .. {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }

    private let secondStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.distribution = .equalCentering
        $0.alignment = .center
    }

    private let infosStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 18
    }

    private let operationLabel = UILabel() .. {
        $0.numberOfLines = 1
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    private let nameLabel = UILabel() .. {
        $0.textColor = Constants.Color.gray
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
    }

    private let amountLabel = UILabel() .. {
        $0.font = UIFont(name: "Ropa Sans Pro Ropa Sans SC Medium", size: 18)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let dateLabel = UILabel() .. {
        $0.textColor = Constants.Color.gray
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    private let pixView = UIView() .. {
        $0.height(24)
        $0.width(48)
        $0.isHidden = true
    }

    private let pixLabel = UILabel() .. {
        $0.text = "PIX"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 10)
        $0.height(22)
        $0.width(48)
    }

    private func configureSubviews() {
        addSubview(totalStackView)
        pixView.addSubview(pixLabel)
        totalStackView.addArrangedSubviews([infosStackView, secondStackView])
        infosStackView.addArrangedSubviews([operationLabel,
                                            nameLabel,
                                            amountLabel])
        secondStackView.addArrangedSubviews([pixView, dateLabel])
    }

    private func configureConstraints() {
        totalStackView.edgesToSuperview(insets: .vertical(48) + .horizontal(28))
    }

    func setup(for statement: StatementItem) {
        operationLabel.text = statement.description
        amountLabel.text = "R$ \(statement.amount),00"
        let date = statement.createdAt
        let dateFormatter = PHDate(dateString: date)
        dateLabel.text = dateFormatter?.string(dateStyle: .short)
        if let destiny = statement.destiny {
            nameLabel.text = destiny
        } else {
            if let origin = statement.origin {
                nameLabel.text = origin
            }
        }
        if statement.tType == "PIXCASHOUT" {
            pixView.isHidden = false
            pixView.backgroundColor = .systemRed
        } else if statement.tType == "PIXCASHIN" {
            pixView.isHidden = false
            pixView.backgroundColor = Constants.Color.cyan
        } else {
            pixView.isHidden = true
        }
    }
}
