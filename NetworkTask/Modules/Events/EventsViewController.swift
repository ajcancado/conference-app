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

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindables()
        setupTableView()
        viewModel.handleEvents()
    }
    
    private func setupBindables() {
        
        viewModel.reloadTableView.bind { value in
            self.tableView.reloadData()
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
