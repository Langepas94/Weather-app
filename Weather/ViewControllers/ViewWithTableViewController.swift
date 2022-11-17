//
//  ViewWithTableViewController.swift
//  Weather
//
//  Created by Артём Тюрморезов on 09.11.2022.
//

import Foundation
import UIKit

class ViewWithTableViewController: UIViewController {
    
    
    
    private var lastUpdateLabel = "Last update"
    
    private let tableViewWeather: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private let nt = NetworkManager()
    
    private let navBarWeather = UINavigationBar()
    
    private let navItemWeather = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewWeather.delegate = self
        tableViewWeather.dataSource = self
        tableViewWeather.separatorStyle = .none
        title = Res.setName.setName(.weatherList)
        setupNavigationBarItems()
        tableViewWeather.backgroundColor = .clear
        tableViewWeather.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        tableViewWeather.allowsSelection = false
        tableViewWeather.showsVerticalScrollIndicator = false
        setupUI()
        
    }
}

extension ViewWithTableViewController {
    func setupUI() {
        
        view.backgroundColor = Res.BackgroundColors.setColor(.background)
        view.addSubview(navBarWeather)
        view.addSubview(tableViewWeather)
        
        navBarWeather.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        tableViewWeather.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableViewWeather.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewWeather.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableViewWeather.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableViewWeather.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}

extension ViewWithTableViewController {
    @objc func searchPressed() {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self]
            city in
            cityMassivchik.insert(city, at: 0)
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(cityMassivchik, forKey: "Massiv")
            UserDefaults.standard.synchronize()
            print(cityMassivchik)
            let ct = cityMassivchik
            print(ct)
            self!.tableViewWeather.reloadData()
        }
    }
}


extension ViewWithTableViewController {
    func setupNavigationBarItems() {
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchPressed))
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add city", style: .plain, target: self, action: #selector(searchPressed))
        
        let leftView = UIView()
        let textToView = UILabel()
        
        leftView.addSubview(textToView)
        
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        textToView.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        textToView.font = .systemFont(ofSize: 13)
        textToView.numberOfLines = 2
        let lastUpdate = ViewWithTableViewController().getLastUpdate()
        textToView.text = "\(lastUpdate) "
        textToView.textAlignment = .left
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
    }
}

extension ViewWithTableViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTable() {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityMassivchik.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityMassivchik.remove(at: indexPath.section)
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(cityMassivchik, forKey: "Massiv")
            UserDefaults.standard.synchronize()
            var set = IndexSet(arrayLiteral: indexPath.section)
            
            print(cityMassivchik)
            tableViewWeather.deleteSections(set, with: .fade)
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = self.tableViewWeather.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.cornerRadius = 10
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.05
        
        nt.fetchData(requestType: .city(city: cityMassivchik[indexPath.section])) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let currentWeather = CurrentWeather(currentWeatherData: data) else {return}
                    
                    let weatherName = UILabel()
                    let weatherTemp = UILabel()
                    let weatherIcon = UIImageView()
                    let weatherDescription = UILabel()
                    
                    weatherName.text = currentWeather.cityName
                    
                    weatherTemp.text = currentWeather.temperatureString + "°"
                    weatherIcon.image = UIImage(systemName: currentWeather.iconNameString)?.withRenderingMode(.alwaysOriginal).withTintColor(Res.BackgroundColors.setColor(.icon))
                    weatherDescription.text = "\(currentWeather.description.localizedCapitalized)," + "\nmin: \(currentWeather.temperatureMinString), max: \(currentWeather.temperatureMaxString)"
                    cell.configureWeather(weatherTemp, weatherIcon: weatherIcon, weatherName: weatherName, weatherDescription: weatherDescription)
                    
                    
                    print(self?.getLastUpdate())
                }
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }
        return cell
    }
}

extension ViewWithTableViewController {
    func getLastUpdate() -> String  {
        let currentTime = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        self.lastUpdateLabel = "Last update - \(hour):\(minute)"
        
        return self.lastUpdateLabel
    }
}
