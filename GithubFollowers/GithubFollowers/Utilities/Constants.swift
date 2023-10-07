//
//  Constants.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 5.10.2023.
//

import Foundation
import UIKit
// MARK: - System Symbols
enum SFSymbols {
    static let location                   = UIImage(systemName: "mappin.and.ellipse")
    static let repos                      = UIImage(systemName: "folder")
    static let gists                      = UIImage(systemName: "text.alignleft")
    static let followers                  = UIImage(systemName: "heart")
    static let following                  = UIImage(systemName: "person.2")
}

// MARK: - Custom Images
enum Images {
    static let ghLogo                     = UIImage(named: "gh-logo")
    static let placeholder                = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo             = UIImage(named: "empty-state-logo")
}

// MARK: - Screen Size Constants
enum ScreenSize {
    static let width                      = UIScreen.main.bounds.size.width
    static let height                     = UIScreen.main.bounds.size.height
    static let maxLength                  = max(ScreenSize.width, ScreenSize.height)
    static let minLength                  = min(ScreenSize.width, ScreenSize.height)
}

// MARK: - Device Type Constants
enum DeviceTypes {
    static let idiom                      = UIDevice.current.userInterfaceIdiom
    static let nativeScale                = UIScreen.main.nativeScale
    static let scale                      = UIScreen.main.scale
    static let is_iPhoneSE                = idiom == .phone && ScreenSize.maxLength == 568.0
    static let is_iPhone8Standard         = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let is_iPhone8Zoomed           = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let is_iPhone8PlusStandard     = idiom == .phone && ScreenSize.maxLength == 736.0
    static let is_iPhone8PlusZoomed       = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let is_iPhoneX                 = idiom == .phone && ScreenSize.maxLength == 812.0
    static let is_iPhoneXsMaxAndXr        = idiom == .phone && ScreenSize.maxLength == 896.0
    static let is_iPad                    = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return is_iPhoneX || is_iPhoneXsMaxAndXr
    }
}
