//
//  ViewController.swift
//  challengePhi
//
//  Created by Angela Alves on 22/08/22.
//

import UIKit

class PHViewController: UIViewController {

    // MARK: Views
    var loadingView = PHLoadingView()

    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lyfe cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingView)
        configureConstraints()
    }

    private func configureConstraints() {
        loadingView.edgesToSuperview()
    }

}

