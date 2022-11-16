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
    var cityMassiv = ["Washington", "Langepas", "Moscow", "London", "Volgograd" ]
    private var background = BackgroundSetup().bgImage
    var lastUpdateLabel = "Last update"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cityMassivchik.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityMassivchik.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.layer.cornerRadius = 15
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
                    weatherIcon.image = UIImage(systemName: currentWeather.iconNameString)?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
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

extension TableViewController {
    func getLastUpdate() -> String  {
        let currentTime = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        self.lastUpdateLabel = "Last update - \n\(hour):\(minute)"
      
        return self.lastUpdateLabel
    }
}

extension TableViewController {
    func fetchWeather() {
        
    }
}
