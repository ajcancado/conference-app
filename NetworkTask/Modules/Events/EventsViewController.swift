//
//  EventsViewController.swift
//  NetworkTask
//
//  Created by Arthur Junqueira Cançado on 05/05/20.
//  Copyright © 2020 Devskiller. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    var viewModel: EventsViewModel = EventsViewModel()
    var customLoading: CustomLoading = CustomLoading()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindables()
        setupTableView()
        viewModel.handleEvents()
    }
    
    private func setupUI() {
        self.navigationItem.title = viewModel.title
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupBindables() {
        
        viewModel.showActivityIndicator.bind { value in
            self.customLoading.showActivityIndicator(uiView: self.view)
        }
        
        viewModel.hideActivityIndicator.bind { value in
            self.customLoading.hideActivityIndicator(uiView: self.view)
        }
        
        viewModel.reloadTableView.bind { value in
            self.tableView.reloadData()
        }
        
        viewModel.showAlertController.bind { alertController in
            self.present(alertController, animated: true)
        }
    }
    
    private func setupTableView() {
        tableView.register(cellType: EventCell.self, bundle: Bundle.main)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
}

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableView(tableView, didSelectRowAt: indexPath)
    }
}
