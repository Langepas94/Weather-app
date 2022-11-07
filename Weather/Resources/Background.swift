//
//  Background.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation
import UIKit

final class Background {
    let bgImage: UIImageView = {
        let background = UIImageView()
//        background.image = UIImage(named: "dayTheme")
        background.image = Res.Images.imageFor(.background)
        return background
    }()
    
    
}

