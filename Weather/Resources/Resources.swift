//
//  Resources.swift
//  Weather
//
//  Created by Артём Тюрморезов on 03.11.2022.
//

import Foundation
import UIKit

enum Imagess: String, CaseIterable {
    case background

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

enum Res {
    enum Images {
        static func imageFor(_ images: Imagess) -> UIImage? {
            switch images {
            case .background: return UIImage(named: "dayTheme")
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
}
