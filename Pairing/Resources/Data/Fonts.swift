//
//  Fonts.swift
//  Pairing
//
//  Created by YOUJIM on 2023/08/13.
//

import Foundation
import SwiftUI

extension Font {
    enum AppleSDGothicNeo {
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        
        var value: String {
            switch self {
            case .extraBold:
                return "AppleSDGothicNeo-ExtraBold"
            case .bold:
                return "AppleSDGothicNeo-Bold"
            case .semiBold:
                return "AppleSDGothicNeo-SemiBold"
            case .medium:
                return "AppleSDGothicNeo-Medium"
            case .regular:
                return "AppleSDGothicNeo-Regular"
            }
        }
    }
    
    static let title1: Font = .custom("AppleSDGothicNeo-Bold", size: 30)
    static let title2: Font = .custom("AppleSDGothicNeo-Bold", size: 28)
    static let title3: Font = .custom("AppleSDGothicNeo-Bold", size: 24)
    static let title4: Font = .custom("AppleSDGothicNeo-Bold", size: 20)
    static let title5: Font = .custom("AppleSDGothicNeo-Bold", size: 18)
    
    static let paragraph1: Font = .custom("AppleSDGothicNeo-SemiBold", size: 16)
    static let paragraph2: Font = .custom("AppleSDGothicNeo-Medium", size: 16)
    static let paragraph3: Font = .custom("AppleSDGothicNeo-Regular", size: 16)
    static let paragraph4: Font = .custom("AppleSDGothicNeo-Medium", size: 14)
    static let paragraph5: Font = .custom("AppleSDGothicNeo-Regular", size: 14)
    
    static let caption1: Font = .custom("AppleSDGothicNeo-SemiBold", size: 12)
    static let caption2: Font = .custom("AppleSDGothicNeo-Medium", size: 12)
    static let caption3: Font = .custom("AppleSDGothicNeo-Regular", size: 12)
}
