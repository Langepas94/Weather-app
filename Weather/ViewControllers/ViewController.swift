//
//  ViewController.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let background = Background().bgImage
    private let nt = NetworkManager()
    private let weatherTempLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.americanTypewriterBold(with: 108)
        weatherLabel.textAlignment = .center
        weatherLabel.textColor = .white
        return weatherLabel
    }()
    
    private let weatherNameLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.font = Res.Fonts.americanTypewriterBold(with: 48)
        weatherLabel.numberOfLines = 0
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
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        network()
        
    }
}

extension ViewController {
    private func setupViews() {
        // MARK: - Add subviews
        view.addSubview(background)
        background.frame = view.bounds
        view.addSubview(weatherTempLabel)
        view.addSubview(weatherNameLabel)
        view.addSubview(weatherFeelLikeLabel)
        view.addSubview(weatherMaxLabel)
        view.addSubview(weatherMinLabel)
        view.addSubview(weatherWindSpeedLabel)
        view.addSubview(weatherDescriptionLabel)
        view.addSubview(weatherImage)
        view.addSubview(tempDescriptionStackView)
        view.addSubview(lastTimeOfUpdatedLabel)
        view.addSubview(minMaxLabelsStackView)
        viewToTemp.addSubview(weatherTempLabel)
        tempDescriptionStackView.addArrangedSubview(viewToTemp)
        
        tempDescriptionStackView.addArrangedSubview(weatherDescriptionLabel)
        tempDescriptionStackView.addArrangedSubview(weatherFeelLikeLabel)
        
        minMaxLabelsStackView.addArrangedSubview(weatherMinLabel)
        minMaxLabelsStackView.addArrangedSubview(weatherMaxLabel)
        minMaxLabelsStackView.addArrangedSubview(weatherWindSpeedLabel)
        
    }
}

extension ViewController {
    func setupConstraints() {
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
 
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            
            
            weatherNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            weatherNameLabel.trailingAnchor.constraint(   equalTo: view.trailingAnchor, constant: Res.InsetsForConstraints.insetTo(.right)),
            weatherNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tempDescriptionStackView.topAnchor.constraint(equalTo: weatherNameLabel.topAnchor, constant: 60),
            tempDescriptionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            minMaxLabelsStackView.centerYAnchor.constraint(equalTo: weatherTempLabel.centerYAnchor),
            minMaxLabelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Res.InsetsForConstraints.insetTo(.right)),
            
            viewToTemp.widthAnchor.constraint(equalToConstant: view.frame.width),
            viewToTemp.heightAnchor.constraint(equalToConstant: 100),
            viewToTemp.centerXAnchor.constraint(equalTo: weatherNameLabel.centerXAnchor),
            
            weatherTempLabel.centerXAnchor.constraint(equalTo: weatherNameLabel.centerXAnchor),
            
            weatherImage.topAnchor.constraint(equalTo: weatherDescriptionLabel.topAnchor, constant: 80),
            weatherImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Res.InsetsForConstraints.insetTo(.right)),
            weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Res.InsetsForConstraints.insetTo(.left)),
            weatherImage.widthAnchor.constraint(equalToConstant: 200),
            weatherImage.heightAnchor.constraint(equalToConstant: 150),
            
            lastTimeOfUpdatedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -20),
            lastTimeOfUpdatedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Res.InsetsForConstraints.insetTo(.left))
            
        ])
    }
}

extension ViewController {
    func network() {
        nt.fetchData { [unowned self] result in
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
