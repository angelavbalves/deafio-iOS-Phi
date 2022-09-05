//
//  StatementViewController.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation
import UIKit

class StatementViewController: PHViewController {

    private lazy var statementView = StatementView(didSelectStatement: didSelectStatement(_:),
                                                   fetchMoreStatements: { [weak self] in
                                                       self?.fetchStatements()
                                                   })
    private var currentPage = 1
    private var totalPage = 6

    // MARK: Lyfe Cycle
    override func loadView() {
        view = statementView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
    }

    override func viewWillAppear(_ animated: Bool) {
        downloadStatementAndAmount()
    }

    // MARK: Aux
    func configureNav() {
        navigationItem.title = "Extrato"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constants.Color.darkGray]
    }

    func fetchStatements(showLoadingView: Bool = true, _ completion: (() -> Void)? = nil) {
        if showLoadingView { loadingView.show() }
        Service.makeRequest(endpoint: ApiEndpoints.statement(offset: currentPage)) { (result: Result<StatementResponse, ErrorState>) in
            switch result {
                case let .success(statementResults):
                    DispatchQueue.main.async { [weak self] in
                        self?.statementView.reloadTableView(with: statementResults.items)
                        self?.currentPage += 1
                        completion?()
                        if showLoadingView { self?.loadingView.hide() }
                    }
                case .failure: return
            }
        }
    }

    func fetchAmount(_ completion: (() -> Void)? = nil) {
        Service.makeRequest(endpoint: ApiEndpoints.balance) { (result: Result<Balance, ErrorState>) in
            switch result {
                case let .success(amountResults):
                    DispatchQueue.main.async { [weak self] in
                        self?.statementView.headerView.setup(for: amountResults)
                        completion?()
                    }
                case .failure: return
            }
        }
    }

    func downloadStatementAndAmount() {
        let dispatchGroup = DispatchGroup()
        loadingView.show()
        dispatchGroup.enter()
        fetchAmount { dispatchGroup.leave() }
        dispatchGroup.enter()
        fetchStatements(showLoadingView: false) { dispatchGroup.leave() }
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.loadingView.hide()
        }
    }

    func didSelectStatement(_ statement: StatementItem) {
        let controller = DetailStatementViewController(for: statement)
        navigationController?.pushViewController(controller, animated: true)
    }
}
