//
//  ViewController.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var background = Background().bgImage
    
    private let nt = NetworkManager()
    
    private let weatherTempLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.americanTypewriterBold(with: 108)
        weatherLabel.textAlignment = .center
        weatherLabel.text = "-"
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherNameLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.americanTypewriterBold(with: 48)
        weatherLabel.numberOfLines = 1
        weatherLabel.textAlignment = .center
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherFeelLikeLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.helveticaregular(with: 22)
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherMaxLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.helveticaregular(with: 28)
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherMinLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.helveticaregular(with: 28)
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherWindSpeedLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.helveticaregular(with: 28)
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.helveticaregular(with: 22)
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        return weatherImage
    }()
    
    private let lastTimeOfUpdatedLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.helveticaregular(with: 12)
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let tempDescriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private let minMaxLabelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private let viewToTemp: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private var locationManaging: CLLocationManager = {
        let loc = CLLocationManager()
        loc.desiredAccuracy = kCLLocationAccuracyBest
        return loc
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.bounces  = true
        return scroll
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = false
        indicator.transform = CGAffineTransform(scaleX: 5, y: 5)
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        
        locationManaging.delegate = self
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManaging.requestLocation()
                self.locationManaging.startUpdatingLocation()
             }
        }
        pullToRefresh()
    }
}

extension ViewController {
    private func setupViews() {
        // MARK: - Add subviews
        view.addSubview(background)
        background.frame = view.bounds
        view.addSubview(scrollView)
        scrollView.addSubview(weatherTempLabel)
        scrollView.addSubview(weatherNameLabel)
        scrollView.addSubview(weatherFeelLikeLabel)
        scrollView.addSubview(weatherMaxLabel)
        scrollView.addSubview(weatherMinLabel)
        scrollView.addSubview(weatherWindSpeedLabel)
        scrollView.addSubview(weatherDescriptionLabel)
        scrollView.addSubview(weatherImage)
        scrollView.addSubview(tempDescriptionStackView)
        scrollView.addSubview(lastTimeOfUpdatedLabel)
        scrollView.addSubview(minMaxLabelsStackView)
        viewToTemp.addSubview(weatherTempLabel)
        tempDescriptionStackView.addArrangedSubview(viewToTemp)
        
        tempDescriptionStackView.addArrangedSubview(weatherDescriptionLabel)
        tempDescriptionStackView.addArrangedSubview(weatherFeelLikeLabel)
        
        minMaxLabelsStackView.addArrangedSubview(weatherMinLabel)
        minMaxLabelsStackView.addArrangedSubview(weatherMaxLabel)
        minMaxLabelsStackView.addArrangedSubview(weatherWindSpeedLabel)
        
        scrollView.addSubview(refreshControl)
        scrollView.addSubview(activityIndicator)
    }
}

extension ViewController {
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        weatherTempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherFeelLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherMinLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherWindSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        tempDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        minMaxLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        viewToTemp.translatesAutoresizingMaskIntoConstraints = false
        lastTimeOfUpdatedLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
 
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            weatherNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: Res.InsetsForConstraints.insetTo(.betweenElementsSmall)),
            weatherNameLabel.trailingAnchor.constraint(   equalTo: scrollView.trailingAnchor, constant: Res.InsetsForConstraints.insetTo(.right)),
            weatherNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Res.InsetsForConstraints.insetTo(.descriptionLeft)),
            
            tempDescriptionStackView.topAnchor.constraint(equalTo: weatherNameLabel.topAnchor, constant: Res.InsetsForConstraints.insetTo(.betweenElementsLarge)),
            tempDescriptionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            minMaxLabelsStackView.centerYAnchor.constraint(equalTo: weatherTempLabel.centerYAnchor),
            minMaxLabelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Res.InsetsForConstraints.insetTo(.right)),
            
            viewToTemp.widthAnchor.constraint(equalToConstant: view.frame.width),
            viewToTemp.heightAnchor.constraint(equalToConstant: 100),
            viewToTemp.centerXAnchor.constraint(equalTo: weatherNameLabel.centerXAnchor),
            
            weatherTempLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10),
            
            lastTimeOfUpdatedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                           constant: Res.InsetsForConstraints.insetTo(.bottomGrid)),
            lastTimeOfUpdatedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Res.InsetsForConstraints.insetTo(.left)),
            
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
        ])
    }
}

extension ViewController {
    
    func network() {
        nt.fetchData(requestType: .city(city: "Langepas")) { [unowned self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                    guard let currentWeather = CurrentWeather(currentWeatherData: data) else {return}
                    self.weatherTempLabel.text = currentWeather.temperatureString + "°"
                    self.weatherNameLabel.text = currentWeather.cityName
                    self.weatherFeelLikeLabel.text = "feel like " + currentWeather.feelsLikeString + "°" + "," + " wind: \(currentWeather.windSpeedString) m/s"
                    self.weatherDescriptionLabel.text = currentWeather.description + "," + " max.: \(currentWeather.temperatureMaxString)°, min.: \(currentWeather.temperatureMinString)°"
                    
                    self.getLastUpdateTime()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}

extension ViewController {
    func getLastUpdateTime() {
        let currentTime = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        self.lastTimeOfUpdatedLabel.text = "Last update - \(hour):\(minute)"
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    // MARK: - setup location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        nt.fetchData(requestType: .location(latitude: latitude, longitude: longitude)) { [unowned self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                    guard let currentWeather = CurrentWeather(currentWeatherData: data) else {return}
                    self.weatherTempLabel.text = currentWeather.temperatureString + "°"
                    self.weatherNameLabel.text = currentWeather.cityName
                    self.weatherFeelLikeLabel.text = "feel like " + currentWeather.feelsLikeString + "°" + "," + " wind: \(currentWeather.windSpeedString) m/s"
                    self.weatherDescriptionLabel.text = currentWeather.description + "," + " max.: \(currentWeather.temperatureMaxString)°, min.: \(currentWeather.temperatureMinString)°"
                    
                    self.getLastUpdateTime()
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                self.weatherTempLabel.text = " Check your internet connection"
                
                print(error.localizedDescription)
            }
        }
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error)
       }
}

extension ViewController {
    func pullToRefresh() {
        refreshControl.addTarget(self, action: #selector(fetchWeatherFromGeo), for: .valueChanged)

    }
    
    @objc func fetchWeatherFromGeo() {
        
        guard let lc = locationManaging.location else {return}
        let latitude = lc.coordinate.latitude
        let longitude = lc.coordinate.longitude
        
        nt.fetchData(requestType: .location(latitude: latitude, longitude: longitude)) { [unowned self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    print(data)
                    guard let currentWeather = CurrentWeather(currentWeatherData: data) else {return}
                    self.weatherTempLabel.text = currentWeather.temperatureString + "°"
                    self.weatherNameLabel.text = currentWeather.cityName
                    self.weatherFeelLikeLabel.text = "feel like " + currentWeather.feelsLikeString + "°" + "," + " wind: \(currentWeather.windSpeedString) m/s"
                    self.weatherDescriptionLabel.text = currentWeather.description + "," + " max.: \(currentWeather.temperatureMaxString)°, min.: \(currentWeather.temperatureMinString)°"
                    
                    self.getLastUpdateTime()
                    
                }
            case .failure(let error):
                self.weatherTempLabel.text = " Check your internet connection"
                print(error.localizedDescription)
                }
            }
        
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            
            let locationManager = CLLocationManager()
               switch manager.authorizationStatus {
               case .authorizedAlways:
                   return
               case .authorizedWhenInUse:
                   return
               case .denied:
                   return
               case .restricted:
                   locationManager.requestWhenInUseAuthorization()
               case .notDetermined:
                   locationManager.requestWhenInUseAuthorization()
               default:
                   locationManager.requestWhenInUseAuthorization()
               }
           }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
           }
        
        refreshControl.endRefreshing()
    }
}
