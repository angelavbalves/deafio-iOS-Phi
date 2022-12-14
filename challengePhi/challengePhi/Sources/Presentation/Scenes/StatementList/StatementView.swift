//
//  StatementView.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import Foundation
import TinyConstraints
import UIKit

class StatementView: PHView {

    // MARK: Properties
    var statements: [StatementItem] = []
    var balance: Int = 0
    let didSelectStatementAction: (_ statement: StatementItem) -> Void
    let fetchMoreStatementsAction: () -> Void
    var isLoadingMoreStatements = false

    // MARK: Views
    let headerView = HeaderView() .. {
        $0.height(110)
    }

    private lazy var tableView = PHTableView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.headerView = headerView
        $0.register(StatementCell.self, forCellReuseIdentifier: StatementCell.identifer)
        $0.delegate = self
        $0.dataSource = self
    }

    // MARK: Init
    init(didSelectStatement: @escaping (_ statement: StatementItem) -> Void, fetchMoreStatements: @escaping () -> Void) {
        didSelectStatementAction = didSelectStatement
        fetchMoreStatementsAction = fetchMoreStatements
        super.init()
    }

    // MARK: Aux
    override func configureSubviews() {
        addSubview(tableView)
    }

    override func configureConstraints() {
        tableView.edgesToSuperview()
    }

    func reloadTableView(with statements: [StatementItem]) {
        self.statements += statements
        tableView.reloadData()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        let distanceFromBottom = contentHeight - offsetY

        if
            isLoadingMoreStatements == false,
            contentHeight > height,
            distanceFromBottom < height
        {
            isLoadingMoreStatements = true
            fetchMoreStatementsAction()
        }
    }
}

extension StatementView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Suas movimenta????es"
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statement = statements[indexPath.row]
        didSelectStatementAction(statement)
    }
}

extension StatementView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatementCell.identifer, for: indexPath) as! StatementCell

        let statement = statements[indexPath.row]
        cell.setup(for: statement)

        return cell
    }
}
