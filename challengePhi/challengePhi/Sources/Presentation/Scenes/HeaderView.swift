//
//  HeaderView.swift
//  challengePhi
//
//  Created by Angela Alves on 23/08/22.
//

import Foundation
import TinyConstraints
import UIKit

class HeaderView: PHView {

    // MARK: Properties
    private var isShowingBalance = false
    private var balance: Int = 0

    // MARK: Init

    override init() {
        super.init()
        backgroundColor = Constants.Color.lightGray
    }

    // MARK: Views
    private let amountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12

        return stackView
    }()

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6

        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Tanseek Modern Arabic Medium", size: 18)
        label.text = "Seu saldo"

        return label
    }()

    private let eyeButton: UIButton = {
        let button = UIButton()
        let eyeImage = UIImage(systemName: "eye")?.withTintColor(Constants.Color.cyan, renderingMode: .alwaysOriginal)
        button.setImage(eyeImage, for: .normal)
        button.addTarget(self, action: #selector(didTapOnEyeButton), for: .touchUpInside)

        return button
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ropa Sans Pro Ropa Sans SC Medium", size: 28)
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        label.textColor = Constants.Color.cyan
        label.text = "R$ 0,00"

        return label
    }()

    override func configureSubviews() {
        addSubview(amountStackView)
        amountStackView.addArrangedSubview(titleStackView)
        amountStackView.addArrangedSubview(amountLabel)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(eyeButton)
        titleStackView.addArrangedSubview(UIView())
    }

    override func configureConstraints() {
        amountStackView.edgesToSuperview(insets: .left(16) + .vertical(16))
    }

    func setup(for balance: Balance) {
        self.balance = balance.amount
        amountLabel.text = "R$ \(balance.amount),00"
    }

    @objc func didTapOnEyeButton() {
        if isShowingBalance {
            isShowingBalance = false
            manageBalanceVisibility(shouldShow: true)
        } else {
            isShowingBalance = true
            manageBalanceVisibility(shouldShow: false)
        }
    }

    func manageBalanceVisibility(shouldShow: Bool) {
        if shouldShow {
            let eyeImage = UIImage(systemName: "eye")?.withTintColor(Constants.Color.cyan, renderingMode: .alwaysOriginal)
            eyeButton.setImage(eyeImage, for: .normal)
            amountLabel.text = "R$ \(balance),00"
        } else {
            let eyeImageSlash = UIImage(systemName: "eye.slash")?.withTintColor(Constants.Color.cyan, renderingMode: .alwaysOriginal)
            eyeButton.setImage(eyeImageSlash, for: .normal)
            amountLabel.text = "----"
        }
    }
}
