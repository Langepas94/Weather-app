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
    case semiLeft
    case left
    case right
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
            case .semiLeft: return 70
            case .left: return 15
            case .right: return -15
            }
        }
    }
}
