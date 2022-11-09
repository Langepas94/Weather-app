//
//  ViewWithTableViewController.swift
//  Weather
//
//  Created by Артём Тюрморезов on 09.11.2022.
//

import Foundation
import UIKit

class ViewWithTableViewController: UIViewController {
    private var background = BackgroundSetup().bgImage
    private let tableViewWeather = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraints()
    }
}

extension ViewWithTableViewController {
    func constraints() {
        
        view.addSubview(background)
        view.addSubview(tableViewWeather.tableView)
        background.frame = view.bounds
        tableViewWeather.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            tableViewWeather.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewWeather.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableViewWeather.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableViewWeather.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        
        ])
    }
}
