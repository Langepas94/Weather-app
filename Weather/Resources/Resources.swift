//
//  Resources.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation
import UIKit

enum Imagess: String, CaseIterable {
    case backgroundStandart
    case backgroundCloudRainBolt
    case backgroundCloudDrizzle
    case backgroundCloudRain
    case backgroundSnow
    case backgroundSmoke
    case backgroundSunny
    case backgroundCloudy
}

enum Sides: String, CaseIterable {
    case descriptionLeft
    case descriptionRight
    case left
    case right
    case betweenElementsSmall
    case betweenElementsLarge
    case bottomGrid
}

enum CellSides: String, CaseIterable {
    case topConstraint
    case leadingConstraint
    case trailingConstraint
    case bottomConstraint
    case betweenHorizontalConstraint
    case betweenVerticalConstraint
}

enum StringNames: String, CaseIterable {
    case mainWeather
    case weatherList
}

enum Res {
    enum Images {
        static func imageFor(_ images: Imagess) -> UIImage? {
            switch images {
            case .backgroundStandart: return UIImage(named: "dayTheme")
            case .backgroundCloudRainBolt: return UIImage(named: "dayTheme")
            case .backgroundCloudDrizzle: return UIImage(named: "dayTheme")
            case .backgroundCloudRain: return UIImage(named: "dayTheme")
            case .backgroundSnow: return UIImage(named: "dayTheme")
            case .backgroundSmoke: return UIImage(named: "dayTheme")
            case .backgroundSunny: return UIImage(named: "dayTheme")
            case .backgroundCloudy: return UIImage(named: "dayTheme")
            }
        }
    }
    
    enum Fonts {
        static func helveticaregular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
        static func americanTypewriterBold (with size: CGFloat) -> UIFont {
            UIFont(name: "AppleSDGothicNeo-Bold", size: size) ?? UIFont()
        }
    }
    
    enum InsetsForConstraints {
        static func insetTo(_ side: Sides ) -> CGFloat {
            switch side {
            case .descriptionLeft: return 10
            case .descriptionRight: return -10
            case .left: return 15
            case .right: return -15
            case .betweenElementsSmall: return 10
            case.bottomGrid: return -20
            case .betweenElementsLarge: return 50
            }
        }
    }
    
    enum InsetsForCellConstraints {
        static func insetTo(_ side: CellSides ) -> CGFloat {
            switch side {
            case .topConstraint: return 10
            case .bottomConstraint: return -10
            case .trailingConstraint: return -15
            case .leadingConstraint: return 15
            case .betweenHorizontalConstraint: return 10
            case .betweenVerticalConstraint: return 20
            }
        }
    }
    
    enum setName{
        static func setName(_ name: StringNames) -> String {
            switch name {
            case .mainWeather: return "Main weather"
            case .weatherList: return "Weather list"
            }
        }
    }
}
