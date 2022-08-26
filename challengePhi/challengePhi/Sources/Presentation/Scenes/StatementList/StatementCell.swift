//
//  StatementCell.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation
import UIKit
import TinyConstraints

class StatementCell: UITableViewCell {

    // MARK: Properties
    static let identifer = "idStatementList"

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Views
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        return stackView
    }()

    private let infosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18

        return stackView
    }()

    private let operationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)

        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Color.gray
        label.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ropa Sans Pro Ropa Sans SC Medium", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 14.0)

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Color.gray
        label.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
        return label
    }()

    private func configureSubviews() {
        addSubview(totalStackView)
        totalStackView.addArrangedSubview(infosStackView)
        infosStackView.addArrangedSubview(operationLabel)
        totalStackView.addArrangedSubview(dateLabel)
        infosStackView.addArrangedSubview(nameLabel)
        infosStackView.addArrangedSubview(amountLabel)
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


    }

}
