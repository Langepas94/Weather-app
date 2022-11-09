//
//  TableViewController.swift
//  Weather
//
//  Created by Артём Тюрморезов on 09.11.2022.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    private let nt = NetworkManager()
    private let temperature = UILabel()
    private var background = BackgroundSetup().bgImage
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        
    }
    
}

extension TableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.selectedBackgroundView?.tintColor = .red
        nt.fetchData(requestType: .city(city: "Langepas")) { [unowned self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                    guard let currentWeather = CurrentWeather(currentWeatherData: data) else {return}
                    self.temperature.text = currentWeather.temperatureString + "°"
                    cell.configureWeather(self.temperature)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    
        return cell
    }
    
}
