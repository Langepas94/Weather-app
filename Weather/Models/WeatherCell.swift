//
//  WeatherCell.swift
//  Weather
//
//  Created by Артём Тюрморезов on 09.11.2022.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    private let weatherIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let weatherName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.tintColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherTemp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherMin: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherMax: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewToIcon: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        backgroundColor = Res.BackgroundColors.setColor(.interfaceView)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureWeather(_ weather: UILabel, weatherIcon: UIImageView, weatherName: UILabel, weatherDescription: UILabel) {
            self.weatherName.text = weatherName.text
            self.weatherTemp.text = weather.text
            self.weatherIcon.image = weatherIcon.image
            self.weatherDescription.text = weatherDescription.text
     }
    
    public func configureError(_ weather: UILabel) {
        self.weatherName.text = weather.text
    }
}

extension WeatherCell {

    func constraints() {
        contentView.addSubview(weatherName)
        contentView.addSubview(weatherTemp)
        contentView.addSubview(weatherMax)
        contentView.addSubview(weatherMin)
        contentView.addSubview(weatherDescription)
        contentView.addSubview(viewToIcon)
        viewToIcon.addSubview(weatherIcon)

        NSLayoutConstraint.activate([
            
            weatherName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Res.InsetsForCellConstraints.insetTo(.leadingConstraint)),
            weatherName.trailingAnchor.constraint(lessThanOrEqualTo: weatherTemp.leadingAnchor),
            weatherName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Res.InsetsForCellConstraints.insetTo(.topConstraint)),
            
            weatherDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Res.InsetsForCellConstraints.insetTo(.bottomConstraint)),
            weatherDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Res.InsetsForCellConstraints.insetTo(.leadingConstraint)),
            weatherDescription.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 2),
            
            weatherTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: Res.InsetsForCellConstraints.insetTo(.trailingConstraint)),
            weatherTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Res.InsetsForCellConstraints.insetTo(.topConstraint)),
            
            viewToIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Res.InsetsForCellConstraints.insetTo(.trailingConstraint)),
            viewToIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Res.InsetsForCellConstraints.insetTo(.bottomConstraint)),
            viewToIcon.widthAnchor.constraint(equalTo: weatherTemp.widthAnchor),
            viewToIcon.heightAnchor.constraint(equalTo: weatherTemp.heightAnchor),
            weatherIcon.centerXAnchor.constraint(equalTo: viewToIcon.centerXAnchor),
//            weatherIcon.centerYAnchor.constraint(equalTo: viewToIcon.centerYAnchor),

            weatherIcon.widthAnchor.constraint(equalToConstant: 30),
            weatherIcon.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
