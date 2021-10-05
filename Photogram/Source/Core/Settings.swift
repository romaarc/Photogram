//
//  Settings.swift
//  Photogram
//
//  Created by Roman Gorshkov on 01.06.2021.
//

import Foundation
import UIKit

public class Settings {
    
    public static let shared = Settings()
    private init() {}
    
    public let placeholderAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.SLWarmGrey, .font: UIFont.systemFont(ofSize: 17)]
    
    public let passwordMinLength: Int = 4
}
