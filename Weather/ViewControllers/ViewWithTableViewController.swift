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
    private let nt = NetworkManager()
    private let navBarWeather = UINavigationBar()
    private let navItemWeather = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Res.setName.setName(.weatherList)
        setupNavigationBarItems()
        
        constraints()
    }
}

extension ViewWithTableViewController {
    func constraints() {
        view.addSubview(navBarWeather)
        navBarWeather.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        view.addSubview(background)
        view.addSubview(tableViewWeather.tableView)
        
        background.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableViewWeather.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            tableViewWeather.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewWeather.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableViewWeather.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableViewWeather.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        
        ])
    }
}

extension ViewWithTableViewController {
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self]
            city in
            
                
                
                cityMassivchik.append(city)
                print(cityMassivchik)
                let ct = cityMassivchik
                print(ct)
                self!.tableViewWeather.tableView.reloadData()
                
         
        }
    }
}

extension ViewWithTableViewController {
    func setupNavigationBarItems() {
       
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add city", style: .plain, target: self, action: #selector(searchPressed))
        let leftView = UIView()
        let textToView = UILabel()
        
        
        
        leftView.addSubview(textToView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        textToView.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        textToView.font = .systemFont(ofSize: 13)
        textToView.numberOfLines = 2
        let lastUpdate = TableViewController().getLastUpdate()
        textToView.text = "\(lastUpdate) "
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
    }
}
