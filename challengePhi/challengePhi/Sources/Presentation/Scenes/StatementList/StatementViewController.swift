//
//  StatementViewController.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation
import UIKit

protocol DelegateStatementController {
    func fetchStatements()
}

class StatementViewController: PHViewController {

    private lazy var statementView = StatementView()
    private var currentPage = 1

    // MARK: Lyfe Cycle

    override func loadView() {
        view = statementView
    }

    override func viewDidLoad() {
        fetchStatements()
        configureNav()
    }

    // MARK: Aux

    func configureNav() {
        navigationItem.title = "Extrato"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.darkGray]
    }
}

extension StatementViewController: DelegateStatementController {
    func fetchStatements() {
        Service.makeRequest(endpoint: ApiEndpoints.statement(offset: currentPage)) { (result: Result<StatementResponse, ErrorState>) in
            switch result {
                case let .success(statementResults):
                    DispatchQueue.main.async { [weak self] in
                        self?.statementView.reloadTableView(with: statementResults.items)
                    }
                case .failure: return
            }
        }
    }

}
