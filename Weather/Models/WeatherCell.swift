//
//  WeatherCell.swift
//  Weather
//
//  Created by Артём Тюрморезов on 09.11.2022.
//

import UIKit

class WeatherCell: UITableViewCell {
    static let identifier = "Cell"
    
    private let weatherTemp: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedBackgroundView?.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWeather(_ weather: UILabel) {
         self.weatherTemp.text = weather.text
     }
    
}

extension WeatherCell {

    func constraints() {
        contentView.addSubview(weatherTemp)
        weatherTemp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            weatherTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }
}
