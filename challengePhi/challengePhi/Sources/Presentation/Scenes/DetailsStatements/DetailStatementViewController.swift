//
//  DetailStatementViewController.swift
//  challengePhi
//
//  Created by Angela Alves on 29/08/22.
//

import Foundation
import UIKit

class DetailStatementViewController: PHViewController {

    // MARK: Properties
    private lazy var detailView = DetailStatement(didTapOnShareButton: { [weak self] in
        self?.shareButton()
    })
    private var statement: StatementItem

    // MARK: Init
    init(for statement: StatementItem) {
        self.statement = statement
        super.init()
    }

    // MARK: Lyfe cicle
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.setup(for: statement)
    }

    func shareButton() {
        let image = detailView.createImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = detailView.shareButton
        present(activityController, animated: true)
    }
}
