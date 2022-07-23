//
//  Settings.swift
//  Photogram
//
//  Created by Roman Gorshkov on 01.06.2021.
//

import Foundation
import UIKit

final class Settings {
    static let shared = Settings()
    let placeholderAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.SLWarmGrey, .font: UIFont.systemFont(ofSize: 17)]
    let passwordMinLength: Int = 4
}
