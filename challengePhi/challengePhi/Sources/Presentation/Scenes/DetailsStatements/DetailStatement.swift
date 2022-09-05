//
//  DetailStatement.swift
//  challengePhi
//
//  Created by Angela Alves on 29/08/22.
//

import Foundation
import TinyConstraints
import UIKit

class DetailStatement: PHView {

    // MARK: Properties
    let didTapOnShareButtonAction: () -> Void

    // MARK: Init
    init(didTapOnShareButton: @escaping () -> Void) {
        didTapOnShareButtonAction = didTapOnShareButton
        super.init()
    }

    // MARK: Views
    private let totalStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 24
    }

    private let dataStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 24
    }

    private let shareButtonStackView = UIStackView() .. {
        $0.axis = .vertical
    }

    let proofView = UIView()

    // MARK: Movement stack
    private let movementStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let proofLabel = UILabel() .. {
        $0.text = "COMPROVANTE"
        $0.textAlignment = .center
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 26)
    }

    private let separator = UIView() .. {
        $0.backgroundColor = Constants.Color.darkGray
        $0.height(1)
    }

    private let typeMovementLabel = UILabel() .. {
        $0.text = "Tipo de Movimentação"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let movementLabel = UILabel() .. {
        $0.text = "Descrição"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    // MARK: Amount stack
    private let amountStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let valueLabel = UILabel() .. {
        $0.text = "Valor"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let amountLabel = UILabel() .. {
        $0.text = "R$ 0,00"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    // MARK: Destiny stack
    private let destinyStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let destinyLabel = UILabel() .. {
        $0.text = "Destino"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let destinyName = UILabel() .. {
        $0.text = "Angela Alves"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    // MARK: Bank
    private let bankStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let descriptionBankLabel = UILabel() .. {
        $0.text = "Instituição bancária"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let nameBankLabel = UILabel() .. {
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    // MARK: Date/Hour
    private let dateStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let dateLabel = UILabel() .. {
        $0.text = "Data/Hora"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let dateAndHour = UILabel() .. {
        $0.text = "29/08/2022 - 16:46:02"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    // MARK: Authentication
    private let authenticationStackView = UIStackView() .. {
        $0.axis = .vertical
        $0.spacing = 12
    }

    private let authenticationLabel = UILabel() .. {
        $0.text = "Autenticação"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 14)
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }

    private let authenticationNumber = UILabel() .. {
        $0.text = "123456789"
        $0.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
    }

    // MARK: Share button
    let shareButton = UIButton() .. {
        $0.setTitle("Compartilhar", for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = Constants.Color.cyan
        $0.addTarget(self, action: #selector(didTapOnShareButton), for: .touchUpInside)
    }

    @objc func didTapOnShareButton() {
        didTapOnShareButtonAction()
    }


    // MARK: Aux
    override func configureSubviews() {
        addSubview(totalStackView)

        proofView.addSubview(dataStackView)
        totalStackView.addArrangedSubviews([proofView, shareButtonStackView])

        dataStackView.addArrangedSubviews([
            proofLabel,
            separator,
            movementStackView,
            amountStackView,
            destinyStackView,
            bankStackView,
            dateStackView,
            authenticationStackView,
            UIView(),
        ])

        movementStackView.addArrangedSubviews([typeMovementLabel, movementLabel])

        amountStackView.addArrangedSubviews([valueLabel, amountLabel])

        destinyStackView.addArrangedSubviews([destinyLabel, destinyName])

        bankStackView.addArrangedSubviews([descriptionBankLabel, nameBankLabel])

        dateStackView.addArrangedSubviews([dateLabel, dateAndHour])

        authenticationStackView.addArrangedSubviews([authenticationLabel, authenticationNumber])

        shareButtonStackView.addArrangedSubviews([shareButton])
    }

    override func configureConstraints() {
        totalStackView.edgesToSuperview(insets: .vertical(16) + .horizontal(16), usingSafeArea: true)
        dataStackView.edgesToSuperview(insets: .vertical(16) + .horizontal(16))

    }

    func setup(for statement: StatementItem) {
        movementLabel.text = statement.description
        amountLabel.text = "R$ \(statement.amount),00"
        if let destiny = statement.destiny {
            destinyName.text = destiny
        } else {
            destinyName.text = "Not found destiny"
        }
        let date = statement.createdAt
        let dateFormatter = PHDate(dateString: date)
        dateAndHour.text = dateFormatter?.string(dateStyle: .long, timeStyle: .long)
        authenticationNumber.text = statement.id
        if let nameBank = statement.bankName {
            nameBankLabel.text = nameBank
        } else {
            nameBankLabel.text = "Not found bank name"
        }
    }

    func createImage() -> UIImage {
        return proofView.asImage()
    }
}



